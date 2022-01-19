//
//  MainView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 03/11/2021.
//

import UIKit
import CarBode
import Combine
import SwiftUI
import Firebase
import AlertToast
import CoreLocation
import FirebaseFirestore
import CoreImage.CIFilterBuiltins

struct MainView: View {
    // MARK: App bar properties
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var current = "house.fill"
    @Namespace var animation
    
    @State var halfModal_shown = false
    @State var isHide = false
    @State var showingScanner = false
    
    @State private var patientNumber = ""
    @State private var showSecondView = false
    @State private var showSheetView = false
    @State private var selectedItem = 0
    @State private var showCovidPassSheetView = false
    
    let locationFetch = LocationFetch()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // MARK: Objects
    @EnvironmentObject var authModel : AuthViewModel
    @EnvironmentObject var resultsModel : ResultsViewModel
    @EnvironmentObject var vaccModel : FirstDoseVaccViewModel
    @ObservedObject var qrModel = QrScanViewModel()
    
    // MARK: Alert Toast property
    @State private var showToastAlert = false
    
    init() {
        let barTintColor = UINavigationBarAppearance()
        barTintColor.configureWithOpaqueBackground()
        barTintColor.backgroundColor = UIColor.init(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        barTintColor.titleTextAttributes = [.foregroundColor: UIColor.white]
        barTintColor.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().backgroundColor = UIColor.init(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        UITextView.appearance().backgroundColor = .white
        UIDatePicker.appearance().backgroundColor = UIColor.clear
        UIDatePicker.appearance().tintColor = UIColor.init(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 1.0)
        UINavigationBar.appearance().scrollEdgeAppearance = barTintColor
        UINavigationBar.appearance().standardAppearance = barTintColor
    }
    
    var body: some View {
        Group {
            if authModel.userSession != nil {
                NavigationView {
                    ZStack {
                        bgWhite()
                        
                        VStack {
                            HeaderTop()
                                .frame(height: 225)
                                .foregroundColor(purple).edgesIgnoringSafeArea(.all)
                                .overlay(
                                    VStack(spacing: 22){
                                        if !isHide {
                                            HStack(spacing: 12){
                                                Text("Covitrace")
                                                    .font(.largeTitle)
                                                    .fontWeight(.heavy)
                                                    .foregroundColor(Color(.white))
                                                
                                                Spacer()
                                            }
                                            .padding(.horizontal, 15)
                                        }
                                        
                                        HStack(spacing: 15){
                                            // MARK: Vaccine Pass
                                            VStack(spacing: 1) {
                                                HStack {
                                                    NavigationLink(
                                                        destination: VaccPassView()){
                                                            VStack {
                                                                Image(systemName:"qrcode")
                                                                    .resizable()
                                                                    .frame(width: 25, height: 25)
                                                                    .padding(10)
                                                                    .background(Color.white.opacity(0.1))
                                                                    .clipShape(Circle())
                                                                Text("Pass")
                                                                    .font(.system(size: 11))
                                                                    .foregroundColor(Color.white)
                                                            }
                                                        }
                                                }
                                            }
                                            
                                            // MARK: Vaccination Card
                                            VStack(spacing: 1) {
                                                HStack {
                                                    NavigationLink(
                                                        destination: VaccinationCardView()){
                                                            VStack {
                                                                Image("card-w")
                                                                    .resizable()
                                                                    .frame(width: 25, height: 25)
                                                                    .padding(10)
                                                                    .background(Color.white.opacity(0.1))
                                                                    .clipShape(Circle())
                                                                Text("Vac. Card")
                                                                    .font(.system(size: 11))
                                                                    .foregroundColor(Color.white)
                                                            }
                                                        }
                                                }
                                            }
                                            
                                            // MARK: Digital Cert.
                                            VStack(spacing: 1) {
                                                HStack {
                                                    NavigationLink(
                                                        destination: DigitalCertView()){
                                                            VStack {
                                                                Image("checkmark")
                                                                    .resizable()
                                                                    .frame(width: 25, height: 25)
                                                                    .padding(10)
                                                                    .background(Color.white.opacity(0.1))
                                                                    .clipShape(Circle())
                                                                Text("Certificate")
                                                                    .font(.system(size: 11))
                                                                    .foregroundColor(Color.white)
                                                            }
                                                        }
                                                }
                                            }
                                            
                                            // MARK: Test Results
                                            VStack(spacing: 1) {
                                                HStack {
                                                    NavigationLink(
                                                        destination: TestResultView()){
                                                            VStack {
                                                                Image("folder")
                                                                    .resizable()
                                                                    .frame(width: 25, height: 25)
                                                                    .padding(10)
                                                                    .background(Color.white.opacity(0.1))
                                                                    .clipShape(Circle())
                                                                Text("PCR")
                                                                    .font(.system(size: 11))
                                                                    .foregroundColor(Color.white)
                                                            }
                                                        }
                                                }
                                            }
                                            
                                            
                                            // MARK: Previous Check-ins
                                            VStack(spacing: 1) {
                                                HStack {
                                                    NavigationLink(
                                                        destination: CheckInView()){
                                                            VStack {
                                                                Image("venue")
                                                                    .resizable()
                                                                    .frame(width: 25, height: 25)
                                                                    .padding(10)
                                                                    .background(Color.white.opacity(0.1))
                                                                    .clipShape(Circle())
                                                                Text("Check-ins")
                                                                    .font(.system(size: 12))
                                                                    .foregroundColor(Color.white)
                                                            }
                                                        }
                                                }
                                            }
                                            
                                            Spacer()
                                        }.padding(.horizontal, 15)
                                        
                                        Spacer()
                                            .frame(height: 5)
                                    }).padding(.bottom, 10)
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                
                                // MARK: Profile Summary
                                VStack(spacing: 5){
                                    if showSecondView {
                                        VStack {
                                            
                                            // MARK: Profile Image
                                            if authModel.user!.verified == "Verified" ||  authModel.user!.verified == "verified" {
                                                ProfileImageView()
                                                    .clipShape(Circle())
                                                    .frame(width: 350, height: 250)
                                                    .foregroundColor(Color(.white))
                                                    .padding(7.5)
                                                    .background(Circle()
                                                                    .fill(green))
                                            } else if authModel.user!.verified == "Pending" || authModel.user!.verified == "pending" {
                                                ProfileImageView()
                                                    .clipShape(Circle())
                                                    .frame(width: 350, height: 250)
                                                    .foregroundColor(Color(.white))
                                                    .padding(7.5)
                                                    .background(Circle()
                                                                    .fill(Color.orange))
                                            } else {
                                                ProfileImageView()
                                                    .clipShape(Circle())
                                                    .frame(width: 350, height: 250)
                                                    .foregroundColor(Color(.white))
                                                    .padding(7.5)
                                                    .background(Circle()
                                                                    .fill(purple))
                                            }
                                            
                                            // MARK: User Name
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text("\(authModel.user?.firstName ?? "")" + " " + "\(authModel.user?.lastName ?? "")")
                                                    .font(.custom("Avenir", size: 21))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                
                                                // MARK: ID Number
                                                HStack {
                                                    Text("ID Number: ")
                                                        .font(.custom("Avenir", size: 18))
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                    Text(authModel.user?.idNumber ?? "")
                                                        .font(.custom("Avenir", size: 18))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                }
                                                
                                                // MARK: Verification Status
                                                HStack{
                                                    Text("Profile Verification: ")
                                                        .font(.custom("Avenir", size: 18))
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                    Text(authModel.user!.verified)
                                                        .font(.custom("Avenir", size: 18))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                }.padding(.bottom, 10)
                                                
                                                HStack(spacing: 5) {
                                                    
                                                    // MARK: User Profile
                                                    NavigationLink(
                                                        destination: UserProfileView()){
                                                            VStack(spacing: 1) {
                                                                Image("user")
                                                                    .resizable()
                                                                    .frame(width: 25, height: 25)
                                                                    .padding(1)
                                                                Text("User")
                                                                    .foregroundColor(Color(.white))
                                                                    .font(.custom("Avenir", size: 10))
                                                                    .fontWeight(.semibold)
                                                                Text("Profile")
                                                                    .foregroundColor(Color(.white))
                                                                    .font(.custom("Avenir", size: 10))
                                                                    .fontWeight(.semibold)
                                                            }
                                                        }.buttonStyle(purpleRoundButton())
                                                    
                                                    // MARK: Scan QR
                                                    VStack(spacing: 5) {
                                                        VStack {
                                                            Button(action: {
                                                                self.showingScanner.toggle()
                                                            }, label: {
                                                                VStack(spacing: 1) {
                                                                    Image("scan")
                                                                        .resizable()
                                                                        .frame(width: 25, height: 25)
                                                                        .padding(1)
                                                                    Text("Scan")
                                                                        .foregroundColor(Color(.white))
                                                                        .font(.custom("Avenir", size: 10))
                                                                        .fontWeight(.semibold)
                                                                    Text("QR code")
                                                                        .foregroundColor(Color(.white))
                                                                        .font(.custom("Avenir", size: 10))
                                                                        .fontWeight(.semibold)
                                                                }
                                                            })
                                                        }
                                                        .buttonStyle(purpleRoundButton())
                                                        .sheet(isPresented: $showingScanner) {
                                                            ModalScannerView()
                                                        }
                                                    }
                                                    
                                                    // MARK: Venue Check-in
                                                    HStack {
                                                        Button(action: {
                                                            if let locationCheckin = self.locationFetch.lastLocation{
                                                                print("Your location is: \(locationCheckin)")
                                                                var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
                                                                let ceo: CLGeocoder = CLGeocoder()
                                                                center.latitude = locationCheckin.latitude
                                                                center.longitude = locationCheckin.longitude
                                                                
                                                                let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
                                                                
                                                                ceo.reverseGeocodeLocation(loc, completionHandler:
                                                                                            {(placemarks, error) in
                                                                    if (error != nil)
                                                                    {
                                                                        print("reverse geodcode fail: \(error!.localizedDescription)")
                                                                    }
                                                                    let pm = placemarks! as [CLPlacemark]
                                                                    if pm.count > 0 {
                                                                        let pm = placemarks![0]
                                                                        var addressString : String = ""
                                                                        
                                                                        if pm.name != nil {
                                                                            addressString = addressString + pm.name! + ", "
                                                                        }
                                                                        if pm.subLocality != nil {
                                                                            addressString = addressString + pm.subLocality! + ", "
                                                                        }
                                                                        if pm.thoroughfare != nil {
                                                                            addressString = addressString + pm.thoroughfare! + ", "
                                                                        }
                                                                        if pm.locality != nil {
                                                                            addressString = addressString + pm.locality! + ", "
                                                                        }
                                                                        if pm.country != nil {
                                                                            addressString = addressString + pm.country!
                                                                        }
                                                                        
                                                                        let formatter = DateFormatter()
                                                                        formatter.locale = Locale(identifier: "nl_NL")
                                                                        formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
                                                                        
                                                                        let now = Date()
                                                                        let datetime = formatter.string(from: now)
                                                                        
                                                                        let db = Firestore.firestore();                                db.collection("checkins").document().setData(["userId": authModel.userSession!.uid, "latitude": locationCheckin.latitude, "longitude": locationCheckin.longitude, "date": datetime, "address": addressString])
                                                                    }
                                                                    showToastAlert.toggle()
                                                                })
                                                            } else {
                                                                print("Unknown location")
                                                            }
                                                        }, label: {
                                                            VStack(spacing: 1) {
                                                                Image("location")
                                                                    .resizable()
                                                                    .frame(width: 25, height: 25)
                                                                    .padding(1)
                                                                Text("Venue")
                                                                    .foregroundColor(Color(.white))
                                                                    .font(.custom("Avenir", size: 11))
                                                                    .fontWeight(.semibold)
                                                                Text("Check-in")
                                                                    .foregroundColor(Color(.white))
                                                                    .font(.custom("Avenir", size: 11))
                                                                    .fontWeight(.semibold)
                                                            }
                                                        }).buttonStyle(purpleRoundButton())
                                                    }
                                                    
                                                    // MARK: Settings
                                                    NavigationLink(
                                                        destination: SettingsView()){
                                                            VStack(spacing: 1) {
                                                                Image("more")
                                                                    .resizable()
                                                                    .frame(width: 25, height: 25)
                                                                    .padding(1)
                                                                Text("Settings")
                                                                    .foregroundColor(Color(.white))
                                                                    .font(.custom("Avenir", size: 10))
                                                                    .fontWeight(.semibold)
                                                                Text("")
                                                                    .foregroundColor(Color(.white))
                                                                    .font(.custom("Avenir", size: 10))
                                                                    .fontWeight(.semibold)
                                                            }
                                                        }.buttonStyle(purpleRoundButton())
                                                }
                                            }
                                        }.frame(width: UIScreen.main.bounds.size.width - 40, height: 525)
                                    }
                                    
                                    Spacer()
                                }
                                .onAppear() {
                                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
                                        withAnimation {
                                            self.showSecondView = true
                                        }
                                    }
                                }.animation(.easeIn)
                            }
                        }
                    }
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                }.accentColor(.white)
            } else {
                ProgressLoadingView()
            }
        }
        .toast(isPresenting: $showToastAlert){
            AlertToast(displayMode: .alert, type: .complete(green), title: Optional("Check-in Complete"))
        }
    }
}

extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!).resizable()
        }
        return self.resizable()
    }
}
