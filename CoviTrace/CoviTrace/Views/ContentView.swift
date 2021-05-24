//
//  ContentView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
//

import SwiftUI
import Combine
import Kingfisher
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State var showSecondView = false
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor.init(red: 83 / 255, green: 82 / 255, blue: 116 / 255, alpha: 1.0)
        UITextView.appearance().backgroundColor = .white
        UIDatePicker.appearance().backgroundColor = UIColor.init(red: 46 / 255, green: 153 / 255, blue: 168 / 255, alpha: 1.0)
        UIDatePicker.appearance().tintColor = UIColor.init(red: 83 / 255, green: 82 / 255, blue: 116 / 255, alpha: 1.0)
    }
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                NavigationView {
                    ZStack
                    {
                        // MARK: BACKGROUND COLOUR CODE:
                        Background()
                        
                        Form {
                            Section {
                                
                                // MARK: User Profile
                                if showSecondView {
                                    
                                    VStack(alignment:.center){
                                        let fullName = ("\(viewModel.user!.fName)" + " " + "\(viewModel.user!.lName)")
                                        Image(systemName: "person.crop.circle.fill")
                                            .data(url: URL(string: "\(viewModel.user!.profileImageUrl)")!)
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 300, height: 100)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                            .shadow(color: Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255), radius: 4, x: 0.0, y: 0.0)
                                        Text("Hello,")
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                        Text("\(fullName)")
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                            .font(.title)
                                        Text(viewModel.user!.verified)
                                            .font(.footnote)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                            .bold()
                                    }
                                    .padding(10)
                                }
                            }.onAppear() {
                                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                                    withAnimation {
                                        self.showSecondView = true
                                    }
                                }
                            }
                        }
                        Spacer(minLength: 10)
                        
                        // MARK: Selection Buttons
                        VStack(alignment: .center) {
                            Spacer(minLength: 5)
                            HStack {
                                // MARK: Test Results
                                NavigationLink(
                                    destination: TestResultView()){
                                    VStack {
                                        Image(systemName: "folder")
                                            .font(.largeTitle)
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        Text("Test Results")
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                            .padding(.top, 5)
                                    }
                                }.frame(width: 150, height: 150)
                                .padding(5)
                                .background(Color(.white))
                                .cornerRadius(15)
                                
                                // MARK: Vaccination Card
                                NavigationLink(
                                    destination: VaccCertView()){
                                    VStack {
                                        Image("barcode")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 35, height: 35)
                                        Text("Vaccination")
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                            .padding(.top, 5)
                                    }
                                }.frame(width: 150, height: 150)
                                .padding(5)
                                .background(Color(.white))
                                .cornerRadius(15)
                            }
                            
                            HStack(alignment: .center) {
                                // MARK: Check-in
                                NavigationLink(
                                    destination: CheckInView()){
                                    VStack {
                                        Image(systemName: "scope")
                                            .font(.largeTitle)
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        Text("Check-In")
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                            .padding(.top, 5)
                                    }
                                }.frame(width: 150, height: 150)
                                .padding(5)
                                .background(Color(.white))
                                .cornerRadius(15)
                                
                                // MARK: Appointment
                                NavigationLink(
                                    destination: AppointmentView()){
                                    VStack {
                                        Image(systemName: "calendar")
                                            .font(.largeTitle)
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        Text("Appointments")
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                            .padding(.top, 5)
                                    }
                                }.frame(width: 150, height: 150)
                                .padding(5)
                                .background(Color(.white))
                                .cornerRadius(15)
                            }
                            
                            HStack {
                                // MARK: Settings
                                NavigationLink(
                                    destination: InformationView()){
                                    HStack {
                                        Image(systemName: "line.horizontal.3")
                                            .font(.largeTitle)
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        Text("Settings")
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                            .padding(.leading, 15)
                                    }
                                }.frame(width: 315, height: 30)
                                .padding(5)
                                .background(Color(.white))
                                .cornerRadius(10)
                            }
                        }.padding()
                        Spacer()
                        
                    }
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                }
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
