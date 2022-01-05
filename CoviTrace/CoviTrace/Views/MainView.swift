//
//  MainView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 03/11/2021.
//

import UIKit
import Combine
import SwiftUI
import Firebase
import Kingfisher
import AVFoundation
import CoreImage.CIFilterBuiltins

struct MainView: View {
    // MARK: App bar properties
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var current = "house.fill"
    @Namespace var animation
    
    @State var halfModal_shown = false
    @State var formHalfModal_shown = false
    @State var isHide = false
    
    @State private var patientNumber = ""
    @State private var showSecondView = false
    @State private var showSheetView = false
    @State private var selectedItem = 0
    @State private var showCovidPassSheetView = false
    
    // MARK: Objects
    @EnvironmentObject var authModel : AuthViewModel
    @EnvironmentObject var resultsModel : ResultsViewModel
    @EnvironmentObject var vaccModel : FirstDoseVaccViewModel
    
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
                                            .padding(.horizontal)
                                        }
                                        
                                        HStack(spacing: 15){
                                            
                                            // MARK: "upload"
                                            VStack(spacing: 1) {
                                                HStack {
                                                    Button(action: {
                                                        self.formHalfModal_shown.toggle()
                                                    }, label: {
                                                        VStack {
                                                            Image("add")
                                                                .resizable()
                                                                .frame(width: 25, height: 25)
                                                                .padding(10)
                                                                .background(Color.white.opacity(0.1))
                                                                .clipShape(Circle())
                                                            Text("Add")
                                                                .font(.system(size: 11))
                                                                .foregroundColor(Color.white)
                                                        }
                                                    })
                                                }
                                            }
                                            
                                            // MARK: User Profile
                                            VStack(spacing: 1) {
                                                HStack {
                                                    NavigationLink(
                                                        destination: UserProfileView()){
                                                            VStack {
                                                                Image("user")
                                                                    .resizable()
                                                                    .frame(width: 25, height: 25)
                                                                    .padding(10)
                                                                    .background(Color.white.opacity(0.1))
                                                                    .clipShape(Circle())
                                                                Text("Profile")
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
                                                                Text("Card")
                                                                    .font(.system(size: 12))
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
                                                                Text("Results")
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
                                                                Text("Venues")
                                                                    .font(.system(size: 12))
                                                                    .foregroundColor(Color.white)
                                                            }
                                                        }
                                                }
                                            }
                                            
                                            // MARK: Settings
                                            VStack(spacing: 1) {
                                                HStack {
                                                    NavigationLink(
                                                        destination: SettingsView()){
                                                            VStack {
                                                                Image("menu")
                                                                    .resizable()
                                                                    .frame(width: 25, height: 25)
                                                                    .padding(10)
                                                                    .background(Color.white.opacity(0.1))
                                                                    .clipShape(Circle())
                                                                Text("Menu")
                                                                    .font(.system(size: 12))
                                                                    .foregroundColor(Color.white)
                                                            }
                                                        }
                                                }
                                            }
                                            
                                            Spacer()
                                        }.padding(.horizontal, 15)
                                        
                                        Spacer()
                                            .frame(height: 2)
                                    }
                                )
                            
                            ScrollView(.vertical, showsIndicators: false) {
                                
                                // MARK: Profile Summary
                                VStack(spacing: 5){
                                    if showSecondView {
                                        VStack {
                                            
                                            // MARK: Profile Image
                                            if authModel.user!.verified == "Verified" ||  authModel.user!.verified == "verified" {
                                                Image(systemName: "person.crop.circle.fill")
                                                    .data(url: URL(string: "\(authModel.user?.profileImageUrl ?? "")")!)                             .resizable()
                                                    .scaledToFit()
                                                    .clipShape(Circle())
                                                    .frame(width: 350, height: 250)
                                                    .foregroundColor(Color(.white))
                                                    .padding(7.5)
                                                    .background(Circle()
                                                                    .fill(green))
                                            } else if authModel.user!.verified == "Pending" || authModel.user!.verified == "pending" {
                                                Image(systemName: "person.crop.circle.fill")
                                                    .data(url: URL(string: "\(authModel.user!.profileImageUrl)")!)                             .resizable()
                                                    .scaledToFit()
                                                    .clipShape(Circle())
                                                    .frame(width: 350, height: 250)
                                                    .foregroundColor(Color(.white))
                                                    .padding(7.5)
                                                    .background(Circle()
                                                                    .fill(Color.orange))
                                            } else {
                                                Image(systemName: "person.crop.circle.fill")
                                                    .data(url: URL(string: "\(authModel.user!.profileImageUrl)")!)                             .resizable()
                                                    .scaledToFit()
                                                    .clipShape(Circle())
                                                    .frame(width: 350, height: 250)
                                                    .foregroundColor(Color(.white))
                                                    .padding(7.5)
                                                    .background(Circle()
                                                                    .fill(purple))
                                            }
                                            
                                            // MARK: User Name
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text("\(authModel.user!.firstName)" + " " + "\(authModel.user!.lastName)")
                                                    .font(.custom("Avenir", size: 21))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                
                                                // MARK: ID Number
                                                HStack {
                                                    Text("ID Number: ")
                                                        .font(.custom("Avenir", size: 18))
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                    Text(authModel.user!.idNumber)
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
                                                
                                                HStack(spacing: 10) {
                                                    
                                                    // MARK: Vaccination Pass
                                                    HStack {
                                                        NavigationLink(
                                                            destination: VaccPassView()){
                                                                VStack(spacing: 1) {
                                                                    Image(systemName: "qrcode")
                                                                        .font(.system(size: 22))
                                                                        .foregroundColor(Color(.white))
                                                                        .padding(2)
                                                                    Text("Vaccine")
                                                                        .foregroundColor(Color(.white))
                                                                        .font(.custom("Avenir", size: 12))
                                                                        .fontWeight(.semibold)
                                                                    Text("Pass")
                                                                        .foregroundColor(Color(.white))
                                                                        .font(.custom("Avenir", size: 11))
                                                                        .fontWeight(.semibold)
                                                                }
                                                            }.buttonStyle(purpleRoundButton())
                                                    }
                                                    
                                                    // MARK: Venue Check-in
                                                    HStack {
                                                        Button(action: {
                                                            self.halfModal_shown.toggle()
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
                                                    
                                                    // MARK: Digital Certificate
                                                    HStack {
                                                        NavigationLink(
                                                            destination: DigitalCertView()){
                                                                VStack(spacing: 1) {
                                                                    Image("checkmark")
                                                                        .resizable()
                                                                        .frame(width: 25, height: 25)
                                                                        .padding(1)
                                                                    Text("Digital")
                                                                        .foregroundColor(Color(.white))
                                                                        .font(.custom("Avenir", size: 10))
                                                                        .fontWeight(.semibold)
                                                                    Text("Certificate")
                                                                        .foregroundColor(Color(.white))
                                                                        .font(.custom("Avenir", size: 10))
                                                                        .fontWeight(.semibold)
                                                                }
                                                                
                                                            }.buttonStyle(purpleRoundButton())
                                                    }
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
                                }
                                .animation(.easeIn)
                            }
                        }
                        ScannerHalfModalView(isShown: $halfModal_shown, modalHeight: 600) {
                            ScannerView()
                        }
                        
                        Spacer()
                        
                        FormUploadHalfModalView(isShown: $formHalfModal_shown, modalHeight: 600) {
                            UploadInformationView()
                        }
                    }
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                }.accentColor(.white)
            } else {
//                LandingView()
                ProgressLoadingView()
            }
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

// MARK: Corner radius for "HeaderTop"
struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
