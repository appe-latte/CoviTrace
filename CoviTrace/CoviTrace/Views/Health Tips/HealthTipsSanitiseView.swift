//
//  HealthTipsSanitiseView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/02/2021.
//

import SwiftUI

struct HealthTipsSanitiseView: View {
    var body: some View {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    VStack{
                        Text("USE HAND SANITISER")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                        Image("sanitise")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Text("Along with practicing good hygiene, keep all surfaces and places that you touch are disinfected as regularly as possible. Establish a routine for wiping down door handles, kitchen counter-tops and fridge handles with a disinfectant spray or wipes.")
                            .foregroundColor(.white)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .font(.title3)
                            .padding(5)
                    }
                    Spacer()
                }.padding(5)
                .frame(minHeight: 0, maxHeight: 800 )
            }.navigationBarTitle("Health Tips").navigationBarHidden(false)
        }
    }
    
    struct HealthTipsSanitiseView_Previews: PreviewProvider {
        static var previews: some View {
            HealthTipsSanitiseView()
        }
    }
}
