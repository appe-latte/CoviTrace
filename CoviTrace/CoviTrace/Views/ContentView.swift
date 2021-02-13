//
//  ContentView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    
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
                                                        Image(systemName: "line.horizontal.3.circle.fill")
                                                            .foregroundColor(.white)
                                                            .font(.largeTitle)
                                                    }
                            )
                        
                        // MARK: Shield & Status
                        VStack(alignment:.center){
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 150)
                            Text("You are currenly Covid-19:")
                                .foregroundColor(.white)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("NEGATIVE")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .font(.title2)
                            //                    Text("Last test results: 01.01.21")
                            //                        .foregroundColor(.white)
                            
                            NavigationLink(
                                destination: AreaStatsView()){
                                Image(systemName: "map.fill")
                                    .font(.title3)
                                Text("AREA STATISTICS")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .leading)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .cornerRadius(30)
                            
                            // MARK: Symptom Checker
                            NavigationLink(
                                destination: SymptomPageView()){
                                Image(systemName: "stethoscope")
                                    .font(.title3)
                                Text("SYMPTOM CHECKER")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .leading)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .cornerRadius(30)
                            
                            // MARK: Check-in
                            NavigationLink(
                                destination: CheckInView()){
                                Image(systemName: "scope")
                                    .font(.title3)
                                Text("LOCATION CHECK-IN")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .leading)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .cornerRadius(30)
                            
                            // MARK: Test Results
                            NavigationLink(
                                destination: ResultsView()){
                                Image(systemName: "folder.fill")
                                    .font(.title3)
                                Text("COVID RESULTS")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .leading)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .cornerRadius(30)
                            
                            // MARK: Hygiene Tips
                            NavigationLink(
                                destination: HealthTipsPageView()){
                                Image(systemName: "bell.fill")
                                    .font(.title3)
                                Text("HEALTH ADVICE")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .leading)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .cornerRadius(30)
                            
                            // MARK: Exposure
                            Button(action: {
                                
                            }) {
                                HStack {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .font(.title3)
                                    Text("LOG EXPOSURE")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .leading)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color(red: 255 / 255, green: 109 / 255, blue: 90 / 255))
                                .cornerRadius(30)
                            }
//                            Spacer()
                        }.padding()
                        .frame(minHeight: 0, maxHeight: 800)
                        Spacer()
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

