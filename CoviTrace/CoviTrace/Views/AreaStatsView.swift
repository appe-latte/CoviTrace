//
//  AreaStatsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 20/01/2021.
//

import SwiftUI

struct AreaStatsView: View {
    @State var riskLevel = "MEDIUM"
    @State var currentCases: Int = 12976
    @State var deaths : Int = 762
    @State var checkIn = "Euston"
    
    var body: some View {
//        NavigationView {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
                    .ignoresSafeArea()
                    
                    // MARK: Settings
//                    .navigationBarItems(leading:
//                                            NavigationLink(
//                                                destination: ContentView()){
//                                                Image(systemName: "chevron.left")
//                                                Text("BACK")
//                                                    .foregroundColor(.white)
//                                            }
//                    )
                
                // MARK: Map
                VStack(alignment:.center){
                    VStack{
                        MapView()
                            .cornerRadius(15.0)
                            .padding()
                    }
                    
                    VStack{
                        // MARK: Risk Level
                        HStack {
                            Text("Risk Level: \(riskLevel)")
                                .fontWeight(.semibold)
                                .font(.title3)
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 40, alignment: .center)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(Color(red: 195 / 255, green: 216 / 255, blue: 213 / 255))
                        .cornerRadius(15)
                        
                        // MARK: Current Cases
                        HStack {
                            Text("Latest Cases: \(currentCases)")
                                .fontWeight(.semibold)
                                .font(.title3)
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 40, alignment: .center)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(Color(red: 234 / 255, green: 201 / 255, blue: 169 / 255))
                        .cornerRadius(15)
                    }
                    
                    // MARK: Deaths
                    HStack {
                        Text("Latest Deaths: \(deaths)")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 40, alignment: .center)
                    .padding(5)
                    .foregroundColor(.white)
                    .background(Color(red: 171 / 255, green: 110 / 255, blue: 193 / 255))
                    .cornerRadius(15)
                    
                    HStack {
                        Text("Last Check-in: \(checkIn)")
                            .fontWeight(.semibold)
                            .font(.title3)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 40, alignment: .center)
                    .padding(5)
                    .foregroundColor(.white)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                    
                }.padding()
                .frame(minHeight: 0, maxHeight: 800 )
            }
//        }.edgesIgnoringSafeArea(.all)
//        .navigationBarHidden(true)
        
    }
    
    struct AreaStatsView_Previews: PreviewProvider {
        static var previews: some View {
            AreaStatsView()
        }
        
    }
    
    struct ButtonView: View {
        @State var navigationBarBackButtonHidden = false

        var body: some View {
            Button("Show back") {
                self.navigationBarBackButtonHidden = false
            }.navigationBarBackButtonHidden(navigationBarBackButtonHidden)
        }
    }
}

