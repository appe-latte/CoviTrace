//
//  MainView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 03/11/2021.
//

import SwiftUI
import Combine
import Kingfisher
import CoreImage.CIFilterBuiltins
import AVFoundation
import UIKit

struct MainView: View {
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var current = "house.fill"
    @Namespace var animation
    
    @State var isHide = false
    
    @State private var vaccStatus = ""
    @State private var patientNumber = ""
    @State private var showSecondView = false
    @State private var showSheetView = false
    @State private var selectedItem = 0
    @State private var showCovidPassSheetView = false
    
    @EnvironmentObject var viewModel : AuthViewModel
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
            if viewModel.userSession != nil {
                NavigationView {
                    ZStack
                    {
                        Background()
                        
                        VStack(spacing: 0){
                            
                            // MARK: App Bar
                            VStack(spacing: 22){
                                
                                if !isHide{
                                    
                                    HStack(spacing: 12){
                                        
                                        Text("Covitrace")
                                            .font(.largeTitle)
                                            .fontWeight(.heavy)
                                            .foregroundColor(Color(.white))
                                        
                                        Spacer(minLength: 0)
                                        
                                        // MARK: Top Row buttons
                                        HStack(spacing: 15) {
                                            // MARK: Upload Information
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
                                            }.padding(.top, 10)
                                        }.padding(.trailing, 30)
                                        
                                    }
                                    .padding(.horizontal)
                                }
                                
                                // MARK: Bottom Row Icons
                                HStack(spacing: 20){
                                    // MARK: Home Screen
                                    VStack(spacing: 1) {
                                        HStack {
                                            NavigationLink(
                                                destination: VaccPassView()){
                                                    VStack {
                                                        Image(systemName: "qrcode")
                                                            .foregroundColor(.white)
                                                            .padding(10)
                                                            .background(Color.white.opacity(0.1))
                                                            .clipShape(Circle())
                                                        Text("Pass")
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
                                                        Text("Check-ins")
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
                                                        Text("PCR Tests")
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
                                            
                                            //                                            let fullName = ("\(viewModel.user!.firstName)" + " " + "\(viewModel.user!.lastName)")
                                            
                                            // MARK: Profile Image
                                            Image(systemName: "person.crop.circle.fill")
                                                .data(url: URL(string: "\(viewModel.user!.profileImageUrl)")!)
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(Circle())
                                                .frame(width: 300, height: 200)
                                                .foregroundColor(Color(.white))
                                                .padding(5)
                                            
                                            // MARK: User Name
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text("\(viewModel.user!.firstName)" + " " + "\(viewModel.user!.lastName)")
                                                    .font(.title)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                
                                                // MARK: ID Number
                                                HStack{
                                                    Text("ID Number: ")
                                                        .font(.body)
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                    Text(viewModel.user!.idNumber)
                                                        .font(.body)
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                }
                                                
                                                // MARK: Verification Status
                                                HStack{
                                                    Text("Profile Status: ")
                                                        .font(.body)
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                    Text(viewModel.user!.verified)
                                                        .font(.body)
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                }
                                                
                                                // MARK: Vaccination Information
                                                HStack {
                                                    NavigationLink(
                                                        destination: VaccCertView()){
                                                            HStack {
                                                                Image(systemName: "eye")
                                                                    .font(.system(size: 24))
                                                                    .foregroundColor(Color(.white))
                                                                Text("View Certificate")
                                                                    .fontWeight(.semibold)
                                                                    .foregroundColor(Color(.white))
                                                                    .padding(.trailing, 30)
                                                            }
                                                        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .center)
                                                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                        .cornerRadius(10)
                                                }
                                                
                                                // MARK: Venue Check-in
                                                HStack {
                                                    NavigationLink(
                                                        destination: ScannerView()){
                                                            HStack {
                                                                Image(systemName: "barcode")
                                                                    .font(.system(size: 24))
                                                                    .foregroundColor(Color(.white))
                                                                Text("Venue Check-in")
                                                                    .fontWeight(.semibold)
                                                                    .foregroundColor(Color(.white))
                                                                    .padding(.trailing, 25)
                                                            }
                                                        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .center)
                                                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                        .cornerRadius(10)
                                                }
                                            }
                                        }
                                        .frame(width: UIScreen.main.bounds.size.width - 40, height: 525)
                                        .background(Color(.white))
                                        .cornerRadius(15)
                                        .padding(5)
                                    }
                                    
                                    Spacer(minLength: 5)
                                }.onAppear() {
                                    Timer.scheduledTimer(withTimeInterval: 0, repeats: false) { (_) in
                                        withAnimation {
                                            self.showSecondView = true
                                        }
                                    }
                                }
                            }
                            
                        }
                        
                        Spacer(minLength: 20)
                        
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
