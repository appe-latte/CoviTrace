//
//  MainView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 19/01/2021.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
        ZStack
        {
            // MARK: BACKGROUND COLOUR CODE:
            Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
                .ignoresSafeArea()
            
            VStack(alignment:.center){
                Image("safe-mark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
//                Spacer()
                Text("You are currenly Covid-19:")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("NEGATIVE")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .scaledToFit()
                Text("Last test results: 01.01.21")
                    .foregroundColor(.white)
//                Spacer()
                Button(action: {
                    print("show area statistics")
                }) {
                    HStack {
                        Image(systemName: "map.fill")
                            .font(.title3)
                        Text("Area Statistics")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, alignment: .leading)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                }
                Button(action: {
                    print("symptom checker")
                }) {
                    HStack {
                        Image(systemName: "stethoscope")
                            .font(.title3)
                        Text("Symptom Checker")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, alignment: .leading)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                }
                Button(action: {
                    print("show test results")
                }) {
                    HStack {
                        Image(systemName: "folder.fill")
                            .font(.title3)
                        Text("Test Results")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, alignment: .leading)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                }
                Button(action: {
                    print("check-in start")
                }) {
                    HStack {
                        Image(systemName: "scope")
                            .font(.title3)
                        Text("Check-in")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, alignment: .leading)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                }
                Button(action: {
                    print("show hygiene tips")
                }) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .font(.title3)
                        Text("Hygiene Tips")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, alignment: .leading)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                }
                Button(action: {
                    print("log exposure")
                }) {
                    HStack {
                        Image(systemName: "bell.fill")
                            .font(.title3)
                        Text("EXPOSURE ALERT")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 255 / 255, green: 109 / 255, blue: 90 / 255))
                    .cornerRadius(15)
                    
                }
            }.padding()
            .frame(minHeight: 0, maxHeight: 800 )
        }
    }
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
        }
        
    }
}
