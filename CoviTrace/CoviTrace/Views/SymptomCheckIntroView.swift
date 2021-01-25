//
//  SymptomCheckIntro.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 25/01/2021.
//

import SwiftUI

struct SymptomCheckIntroView: View {
    
    var body: some View {
//        NavigationView {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
                    .ignoresSafeArea()
                
                VStack(alignment:.center){
                    VStack{
                        Text("Covid-19 Symptoms")
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(5)
                        Text("Although the symptoms of COVID-19 vary from constant tiredness to aches and pains, there are 3 symptoms to look out for that show you may have contracted the virus. The moment you discover that either you or any of your family members show the symptoms of the virus, please immediately self-isolate and seek testing or medical attention. Contact your local hospital or clinics for information on where testing will take place.")
                            .foregroundColor(.white)
                            .lineLimit(nil)
                            .font(.title3)
                            .padding(5)
                        Text("For more information regarding COVID-19 please visit:")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .lineLimit(nil)
                    }
                    
                    // MARK: Weblinks
                    
                    VStack {
                        // MARK: Latest Deaths Figures
                        Button(action: {
                        }) {
                            VStack {
                                Text("nhs.uk")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 30, alignment: .center)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .cornerRadius(15)
                        }
                        // MARK: Last Check-in
                        Button(action: {
                            print("show area statistics")
                        }) {
                            VStack {
                                Text("who.int")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 30, alignment: .center)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .cornerRadius(15)
                        }
                    }
                }.padding(5)
                .frame(minHeight: 0, maxHeight: 800 )
                Spacer()
            }.navigationBarTitle("Covid-19 Symptoms").navigationBarHidden(false)
//        }.edgesIgnoringSafeArea(.all)
    }
    
    struct SymptomCheckIntroView_Previews: PreviewProvider {
        static var previews: some View {
            SymptomCheckIntroView()
        }
    }
}
