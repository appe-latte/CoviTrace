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
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                Text("You are currenly Covid-19:")
                    .foregroundColor(.white)
                    .font(.title2)
                Text("NEGATIVE")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .scaledToFit()
            }.padding()
            
            
            VStack(alignment:.trailing){
                Spacer()
                Button(action: {
                    print("button 1")
                }) {
                    HStack {
                        Image(systemName: "circle")
                            .font(.title3)
                        Text("AREA STATISTICS")
                            .fontWeight(.bold)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                }
                Button(action: {
                    print("button 2")
                }) {
                    HStack {
                        Image(systemName: "location")
                            .font(.title3)
                        Text("SYMPTOM CHECKER")
                            .fontWeight(.bold)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                }
                Button(action: {
                    print("button 3")
                }) {
                    HStack {
                        Image(systemName: "info.circle")
                            .font(.title3)
                        Text("RESULTS")
                            .fontWeight(.bold)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                }
                Button(action: {
                    print("button 4")
                }) {
                    HStack {
                        Image(systemName: "circle")
                            .font(.title3)
                        Text("CHECK-IN")
                            .fontWeight(.bold)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                }
                Button(action: {
                    print("button 5")
                }) {
                    HStack {
                        Image(systemName: "circle")
                            .font(.title3)
                        Text("HYGIENE TIPS")
                            .fontWeight(.bold)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                }
                Button(action: {
                    print("button 6")
                }) {
                    HStack {
                        Image(systemName: "iphone")
                            .font(.title3)
                        Text("EXPOSURE ALERT")
                            .fontWeight(.bold)
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
