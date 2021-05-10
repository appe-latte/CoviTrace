//
//  ContentView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var firstName = ""
    @State private var lastName = ""
    
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
//                            .navigationBarItems(trailing:
//                                                    NavigationLink(
//                                                        destination: InformationView()){
//                                                        HStack{
//                                                            Image("settings")
//                                                                .resizable()
//                                                                .frame(width: 20, height: 20)
//                                                        }
//                                                        .foregroundColor(.white)
//                                                        .font(.largeTitle)
//
//                                                    }
//                            )
                        
                        Form {
                            // MARK: User:
                            Section {
                                ProfileHeaderView()
                            }.foregroundColor(.white)
   
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

                                // MARK: UK Data
                                NavigationLink(
                                    destination: UKCovidStatsView()){
                                    Image(systemName: "chart.bar")
                                        .font(.title)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        .padding(.trailing, 5)
                                    Text("UK Covid Statistics")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .padding(.leading, 5)
                                }
                                
                                // MARK: Settings
                                NavigationLink(
                                    destination: InformationView()){
                                    Image("settings")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(5)
                                        .scaledToFit()
                                    Text("Settings")
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

