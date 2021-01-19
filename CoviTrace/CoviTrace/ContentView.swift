//
//  ContentView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var dataFetch = DataFetchRequest()
    
    var body: some View {
        
        ZStack
        {
            // MARK: BACKGROUND COLOUR CODE:
            Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
                .ignoresSafeArea()
            
            VStack(alignment:.center){
                Image("wave")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 110)
                Text("CoviTrace App")
                    .foregroundColor(.white)
                    .bold()
                    .font(.largeTitle)
                Text("Covid-19 Track & Trace")
                    .foregroundColor(.white)
            }
            
            VStack(alignment:.trailing) {
                Spacer()
                HStack {
                    //                    Spacer()
                    Button(action: {
                        print("begin onboarding")
                    }) {
                        HStack {
                            Text("ENTER")
                                .fontWeight(.bold)
                            Image(systemName: "chevron.right")
                                .font(.title3)
                        }
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(15)
                        
                        
                        // MARK: Long Button
                        
                        //                        .frame(minWidth: 0, maxWidth: 300)
                        //                        .padding()
                        //                        .foregroundColor(.white)
                        //                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        //                        .cornerRadius(40)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}

