//
//  SymptomCoughView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 25/01/2021.
//

import SwiftUI

struct SymptomCoughView: View {
    
    var body: some View {
//        NavigationView {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    VStack{
                        Text("DRY COUGH")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                        Image("cough")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Text("A new and continuous cough that appears to last for more than an hour is an early signifier for you to immediately self-isolate to reduce the spread of any airborne pathogens to people around you.")
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
    }
    
    struct SymptomCoughView_Previews: PreviewProvider {
        static var previews: some View {
            SymptomCheckIntroView()
        }
    }
}

