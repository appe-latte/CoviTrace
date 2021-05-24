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
                            
                            // MARK: Main Menu
                            Section {
                                
                                // MARK: Test Results
                                NavigationLink(
                                    destination: TestResultView()){
                                    Image(systemName: "folder")
                                        .font(.title)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        .padding(.trailing, 5)
                                    Text("Test Results")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .padding(.leading, 10)
                                }
                                
                                // MARK: Vaccination Information
                                NavigationLink(
                                    destination: VaccCertView()){
                                    Image("barcode")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(5)
                                        .scaledToFit()
                                    Text("Vaccination Card")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .padding(.leading, 15)
                                }
                                
                                // MARK: Check-in
                                NavigationLink(
                                    destination: CheckInView()){
                                    Image(systemName: "scope")
                                        .font(.title)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        .padding(.trailing, 5)
                                    Text("Location Check-in")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .padding(.leading, 10)
                                }
                                
                                // MARK: Appointment
                                NavigationLink(
                                    destination: AppointmentView()){
                                    Image(systemName: "calendar")
                                        .font(.title)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        .padding(.trailing, 5)
                                    Text("Appointments")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .padding(.leading, 15)
                                }
                                
                                // MARK: Hygiene Tips
                                NavigationLink(
                                    destination: HealthTipsPageView()){
                                    Image(systemName: "bell")
                                        .font(.title)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        .padding(.trailing, 5)
                                    Text("Health Tips")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .padding(.leading, 15)
                                }
                                
                                // MARK: Settings
                                NavigationLink(
                                    destination: InformationView()){
                                    Image(systemName: "info.circle")
                                        .font(.title)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        .padding(.trailing, 5)
                                    Text("Useful Information")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .padding(.leading, 15)
                                }
                                
                            }.foregroundColor(.white)
                        }
                    }
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                }
            } else {
                LandingView()
            }
        }.accentColor(.white)
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
