//
//  HealthTipsRestView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/02/2021.
//

import SwiftUI

struct HealthTipsRestView: View {
    var body: some View {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    VStack{
                        Text("GET SOME REST")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                        Image("rest")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Text("Make sure you find time to rest and relax in order to maintain your body's health and mental wellbeing. As well finding time to rest, make sure you include some light physical activities such as going for walks to get you out of the house and improve your fitness at the same. ")
                            .foregroundColor(.white)
                            .lineLimit(nil)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .padding(5)
                    }
                    Spacer()
                }.padding(5)
                .frame(minHeight: 0, maxHeight: 800 )
            }.navigationBarTitle("Health Tips").navigationBarHidden(false)
        }
    }
    
    struct HealthTipsRestView_Previews: PreviewProvider {
        static var previews: some View {
            HealthTipsRestView()
        }
    }
}
