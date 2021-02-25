//
//  ContentView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @ObservedObject private var resultsViewModel = testResultViewModel()
    var testResult = "NEGATIVE"
    
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
                                                            Image(systemName: "info.circle")
                                                            Text("information")
                                                        }
                                                        .foregroundColor(.white)
                                                        .font(.subheadline)
                                                    }
                            )
                        
                        // MARK: Shield & Status
                        Form {
                            Section {
                                VStack(alignment:.center){
                                    Image(systemName: "checkmark.shield")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300, height: 150)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("Latest Covid-19 Result:")
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    Text(testResult)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        .font(.title2)
                                }
                                .padding(10)
                            }
                            
                            // MARK: Map
                            Section {
                                NavigationLink(
                                    destination: AreaStatsView()){
                                    Image(systemName: "map")
                                        //                                        .font(.title3)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("Area Statistics")
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .fontWeight(.semibold)
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
                                
                                // MARK: Check-in
                                NavigationLink(
                                    destination: CheckInView()){
                                    Image(systemName: "scope")
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("Location Check-in")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                }
                                
                                // MARK: Test Results
                                NavigationLink(
                                    destination: ResultsView()){
                                    Image(systemName: "folder")
                                        .font(.title3)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("Test Results")
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
                            }
                            
                            // MARK: Exposure
                            Button(action: {
                                
                            }) {
                                HStack {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .font(.title3)
                                        .foregroundColor(Color(red: 255 / 255, green: 109 / 255, blue: 90 / 255))
                                    Text("LOG EXPOSURE")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .foregroundColor(Color(red: 255 / 255, green: 109 / 255, blue: 90 / 255))
                                }
                                .padding(.leading, 65)
                            }
                        }
                    }
                }
            } else {
                LandingView()
            }
        }.accentColor(.white)
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

