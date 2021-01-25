//
//  SymptomSmellView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 25/01/2021.
//

import SwiftUI

struct SymptomSmellView: View {
    
    var body: some View {
//        NavigationView {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
                    .ignoresSafeArea()
                
                VStack(alignment:.center){
                    VStack{
                        Text("CHANGE TO SENSE OF SMELL")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                        Image("sneeze")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Text("Another good indicator you may have contracted COVID-19 is the discovery of a loss or change to your sense of smell. This also includes a loss of a sense of taste or you discover that things do not smell as normal.")
                            .foregroundColor(.white)
                            .lineLimit(nil)
                            .font(.title3)
                            .padding(5)
                    }
                    Spacer()
                    
                }.padding(5)
                .frame(minHeight: 0, maxHeight: 800 )
            }.navigationBarTitle("Covid-19 Symptoms").navigationBarHidden(false)
//        }.edgesIgnoringSafeArea(.all)
    }
    
    struct SymptomSmellView_Previews: PreviewProvider {
        static var previews: some View {
            SymptomSmellView()
        }
    }
}




