//
//  AreaStatsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 20/01/2021.
//

import SwiftUI

struct AreaStatsView: View {
    @State private var buttonDisabled = true
    
    var body: some View {
//        NavigationView {
            
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
                    .ignoresSafeArea()
                
                VStack(alignment:.center){
                    VStack{
                        MapView()
                            .cornerRadius(15.0)
                            .padding()
                    }
                    
                    HStack {
                        
                        Button(action: {
                            print("show area statistics")
                        }) {
                            VStack {
                                Text("Risk Level:")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Text("MEDIUM")
                                    .fontWeight(.semibold)
                                    .font(.title)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 150, minHeight: 0, maxHeight: 150, alignment: .center)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 195 / 255, green: 216 / 255, blue: 213 / 255))
                            .cornerRadius(15)
                            .disabled(buttonDisabled)
                        }
                        Button(action: {
                        }) {
                            VStack {
                                Text("Latest Cases:")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Text("12,763")
                                    .fontWeight(.semibold)
                                    .font(.title)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 150, minHeight: 0, maxHeight: 150, alignment: .center)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 234 / 255, green: 201 / 255, blue: 169 / 255))
                            .cornerRadius(15)
                        }
                    }
                    
                    // MARK: Second row stats
                    
                    HStack {
                        // MARK: Latest Deaths Figures
                        Button(action: {
                        }) {
                            VStack {
                                Text("Latest Deaths:")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                
                                Text("763")
                                    .fontWeight(.semibold)
                                    .font(.title)
                            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 150, minHeight: 0, maxHeight: 150, alignment: .center)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 171 / 255, green: 110 / 255, blue: 193 / 255))
                            .cornerRadius(15)
                        }
                        // MARK: Last Check-in
                        Button(action: {
                            print("show area statistics")
                        }) {
                            VStack {
                                Text("Last Check-in:")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                Text("Euston")
                                    .fontWeight(.semibold)
                                    .font(.title)
                            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 150, minHeight: 0, maxHeight: 150, alignment: .center)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .cornerRadius(15)
                        }
                    }
                }.padding(5)
                .frame(minHeight: 0, maxHeight: 800 )
            }.navigationBarTitle("Area Statistics")
//        }.edgesIgnoringSafeArea(.all)
//        .navigationBarHidden(true)
    }
    
    struct AreaStatsView_Previews: PreviewProvider {
        static var previews: some View {
            AreaStatsView()
        }
        
    }
    
    struct ButtonView: View {
        @State var navigationBarBackButtonHidden = true

        var body: some View {
            Button("Show back") {
                self.navigationBarBackButtonHidden = false
            }.navigationBarBackButtonHidden(navigationBarBackButtonHidden)
        }
    }
}
