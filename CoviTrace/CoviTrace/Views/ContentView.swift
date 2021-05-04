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
    }
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                NavigationView {
                    ZStack
                    {
                        // MARK: BACKGROUND COLOUR CODE:
                        Background()
                            .navigationBarItems(trailing:
                                                    NavigationLink(
                                                        destination: InformationView()){
                                                        HStack{
                                                            Image(systemName: "ellipsis")
                                                        }
                                                        .foregroundColor(.white)
                                                        .font(.largeTitle)
                                                        
                                                    }
                            )
                        
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
                                        .font(.title3)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("Test Results")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                }
                                
                                // MARK: Vaccination Information
                                NavigationLink(
                                    destination: VaccCertView()){
                                    Image(systemName: "doc")
                                        .font(.title3)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("Vaccination Information")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                }
                                
                                // MARK: Check-in
                                NavigationLink(
                                    destination: CheckInView()){
                                    Image(systemName: "scope")
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("Location Check-in")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                }
                                
                                // MARK: Appointment
                                NavigationLink(
                                    destination: AppointmentView()){
                                    Image(systemName: "calendar")
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("Appointments")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                }
                                
                                // MARK: Symptom Checker
                                NavigationLink(
                                    destination: SymptomPageView()){
                                    Image(systemName: "stethoscope")
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("Check Symptoms")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                }
                                
                                // MARK: Hygiene Tips
                                NavigationLink(
                                    destination: HealthTipsPageView()){
                                    Image(systemName: "bell")
                                        .font(.title3)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("Health Tips")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                }
                                
                                // MARK: UK Data
                                NavigationLink(
                                    destination: UKCovidStatsView()){
                                    Image(systemName: "chart.bar.fill")
                                        .font(.title3)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("UK Covid Statistics")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                }
                                
                            }.foregroundColor(.white)
                        }
                    }
                }
            } else {
                LandingView()
            }
        }.accentColor(.white)
    }
}

