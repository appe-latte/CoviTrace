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
    @State var isHide = false
    
    @State private var vaccStatus = ""
    @State private var patientNumber = ""
    @State private var showSecondView = false
    @State private var showSheetView = false
    @State private var selectedItem = 0
    @State private var showCovidPassSheetView = false
    
    // MARK: Objects
    @EnvironmentObject var authModel : AuthViewModel
    @EnvironmentObject var resultsModel : ResultsViewModel
    @EnvironmentObject var vaccModel : VaccinationViewModel
    
    init() {
        let barTintColor = UINavigationBarAppearance()
        barTintColor.configureWithOpaqueBackground()
        barTintColor.backgroundColor = UIColor.init(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        barTintColor.titleTextAttributes = [.foregroundColor: UIColor.white]
        barTintColor.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().backgroundColor = UIColor.init(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        UITextView.appearance().backgroundColor = .white
        UIDatePicker.appearance().backgroundColor = UIColor.init(red: 46 / 255, green: 153 / 255, blue: 168 / 255, alpha: 1.0)
        UIDatePicker.appearance().tintColor = UIColor.init(red: 83 / 255, green: 82 / 255, blue: 116 / 255, alpha: 1.0)
        UINavigationBar.appearance().scrollEdgeAppearance = barTintColor
        UINavigationBar.appearance().standardAppearance = barTintColor
    }
    
    var body: some View {
        Group {
            if authModel.userSession != nil {
                NavigationView {
                    ZStack
                    {
                        Background()
                        
                        VStack(spacing: 0){
                            // MARK: App Bar
                            VStack(spacing: 22){
                                
                                Spacer()
                                    .frame(height: 15)
                                
                                if !isHide {
                                    
                                    HStack(spacing: 12){
                                        
                                        Text("Covitrace")
                                            .font(.largeTitle)
                                            .fontWeight(.heavy)
                                            .foregroundColor(Color(.white))
                                        
                                        Spacer(minLength: 0)
                                        
                                    }
                                    .padding(.horizontal)
                                }
                                
                                // MARK: Bottom Row Icons
                                HStack(spacing: 20){
                                    // MARK: Home Screen
                                    VStack(spacing: 1) {
                                        HStack {
                                            NavigationLink(
                                                destination: UploadInformationView()){
                                                    VStack {
                                                        Image(systemName: "plus")
                                                            .foregroundColor(.white)
                                                            .padding(10)
                                                            .background(Color.white.opacity(0.1))
                                                            .clipShape(Circle())
                                                        Text("Add")
                                                            .font(.system(size: 12))
                                                            .foregroundColor(Color.white)
                                                    }
                                                }
                                        }
                                    }
                                    
                                    // MARK: User Profile
                                    VStack(spacing: 1) {
                                        HStack {
                                            NavigationLink(
                                                destination: UserProfileView()){
                                                    VStack {
                                                        Image(systemName: "person.fill")
                                                            .foregroundColor(.white)
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
                                    
                                    // MARK: Previous Check-ins
                                    VStack(spacing: 1) {
                                        HStack {
                                            NavigationLink(
                                                destination: CheckInView()){
                                                    VStack {
                                                        Image(systemName: "map")
                                                            .foregroundColor(.white)
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
                                    
                                    // MARK: Test Results
                                    VStack(spacing: 1) {
                                        HStack {
                                            NavigationLink(
                                                destination: TestResultView()){
                                                    VStack {
                                                        Image(systemName: "tray.fill")
                                                            .foregroundColor(.white)
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
                                    
                                    // MARK: Settings
                                    VStack(spacing: 1) {
                                        HStack {
                                            NavigationLink(
                                                destination: SettingsView()){
                                                    VStack {
                                                        Image(systemName: "gearshape")
                                                            .foregroundColor(.white)
                                                            .padding(9)
                                                            .background(Color.white.opacity(0.1))
                                                            .clipShape(Circle())
                                                        Text("Settings")
                                                            .font(.system(size: 12))
                                                            .foregroundColor(Color.white)
                                                    }
                                                }
                                        }
                                    }
                                }
                            }
                            .background(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .padding(.bottom, 20)
                            
                            ScrollView(.vertical, showsIndicators: false) { // Scroll View
                                
                                // MARK: Profile Summary
                                VStack(alignment: .center){
                                    
                                    if showSecondView {
                                        VStack(alignment:.center){
                                            
                                            // MARK: Profile Image
                                            Image(systemName: "person.crop.circle.fill")
                                                .data(url: URL(string: "\(authModel.user!.profileImageUrl)")!) // <- error: occassionally crashes displaying "Unexpectedly found nil while unwrapping an Optional value". Happens mostly at app launch after registration or occassionally when the user is opening the app after a while.
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(Circle())
                                                .frame(width: 300, height: 200)
                                                .foregroundColor(Color(.white))
                                                .padding(5)
                                                .padding(.bottom, 20)
                                            
                                            // MARK: User Name
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text("\(authModel.user!.firstName)" + " " + "\(authModel.user!.lastName)")// <- error: occassionally crashes displaying "Unexpectedly found nil while unwrapping an Optional value". Happens mostly at app launch after registration or occassionally when the user is opening the app after a while.
                                                    .font(.custom("Avenir", size: 21))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                
                                                // MARK: ID Number
                                                HStack{
                                                    Text("ID Number: ")
                                                        .font(.custom("Avenir", size: 18))
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                    Text(authModel.user!.idNumber)// <- error: occassionally crashes displaying "Unexpectedly found nil while unwrapping an Optional value". Happens mostly at app launch after registration or occassionally when the user is opening the app after a while.
                                                        .font(.custom("Avenir", size: 18))
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                }
                                                
                                                // MARK: Verification Status
                                                HStack{
                                                    Text("Profile Status: ")
                                                        .font(.custom("Avenir", size: 18))
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                    Text(authModel.user!.verified)// <- error: occassionally crashes displaying "Unexpectedly found nil while unwrapping an Optional value". Happens mostly at app launch after registration or occassionally when the user is opening the app after a while.
                                                        .font(.custom("Avenir", size: 18))
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                }.padding(.bottom, 10)
                                                
                                                HStack(spacing: 10) {
                                                    
                                                    // MARK: Vaccination Pass
                                                    HStack {
                                                        NavigationLink(
                                                            destination: VaccPassView()){
                                                                VStack(spacing: 1) {
                                                                    Image(systemName: "qrcode")
                                                                        .font(.system(size: 18))
                                                                        .foregroundColor(Color(.white))
                                                                    Text("Vaccine")
                                                                        .foregroundColor(Color(.white))
                                                                        .font(.custom("Avenir", size: 12))
                                                                        .fontWeight(.semibold)
                                                                    Text("Pass")
                                                                        .foregroundColor(Color(.white))
                                                                        .font(.custom("Avenir", size: 11))
                                                                        .fontWeight(.semibold)
                                                                }
                                                            }.frame(width: 80, height: 80)
                                                            .foregroundColor(.white)
                                                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                            .clipShape(Circle())
                                                    }
                                                    
                                                    // MARK: Venue Check-in
                                                    HStack {
                                                        Button(action: {
                                                            self.halfModal_shown.toggle()
                                                        }, label: {
                                                            VStack(spacing: 1) {
                                                                Image(systemName: "barcode")
                                                                    .font(.system(size: 18))
                                                                    .foregroundColor(Color(.white))
                                                                Text("Venue")
                                                                    .foregroundColor(Color(.white))
                                                                    .font(.custom("Avenir", size: 11))
                                                                    .fontWeight(.semibold)
                                                                Text("Check-in")
                                                                    .foregroundColor(Color(.white))
                                                                    .font(.custom("Avenir", size: 11))
                                                                    .fontWeight(.semibold)
                                                            }.frame(width: 80, height: 80)
                                                                .foregroundColor(.white)
                                                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                                .clipShape(Circle())
                                                        })
                                                    }
                                                    
                                                    // MARK: Digital Certificate
                                                    HStack {
                                                        NavigationLink(
                                                            destination: DigitalCertView()){
                                                                VStack(spacing: 1) {
                                                                    Image(systemName: "seal.fill")
                                                                        .font(.system(size: 18))
                                                                        .foregroundColor(Color(.white))
                                                                    Text("Digital")
                                                                        .foregroundColor(Color(.white))
                                                                        .font(.custom("Avenir", size: 10))
                                                                        .fontWeight(.semibold)
                                                                    Text("Certificate")
                                                                        .foregroundColor(Color(.white))
                                                                        .font(.custom("Avenir", size: 10))
                                                                        .fontWeight(.semibold)
                                                                }
                                                                
                                                            }.frame(width: 80, height: 80)
                                                            .foregroundColor(.white)
                                                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                            .clipShape(Circle())
                                                    }
                                                }
                                            }
                                        }
                                        .frame(width: UIScreen.main.bounds.size.width - 40, height: 525)
                                        .background(Color(.white))
                                        .cornerRadius(15)
                                        .padding(5)
                                        
                                    }
                                    
                                    Spacer()
                                    
                                }.onAppear() {
                                    Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { (_) in
                                        withAnimation {
                                            self.showSecondView = true
                                        }
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                        HalfModalView(isShown: $halfModal_shown, modalHeight: 600){
                            ScannerView()
                        }
                    }
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                }.accentColor(.white)
            } else {
                LandingView()
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
