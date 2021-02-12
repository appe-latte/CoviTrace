//
//  HealthTipsDistanceView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/02/2021.
//

import SwiftUI

struct HealthTipsDistanceView: View {
    var body: some View {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    VStack{
                        Text("WEAR YOUR MASK & PRACTICE SOCIAL DISTANCING")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                        Image("mask")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Text("Always wear your face mask when travelling outside and in all public spaces. Follow your local council or government regulations on social distancing by allowing at least a minimum of 1.5m between you and other people.")
                            .foregroundColor(.white)
                            .lineLimit(nil)
                            .font(.title3)
                            .padding(5)
                    }
                    Spacer()
                }.padding(5)
                .frame(minHeight: 0, maxHeight: 800 )
            }.navigationBarTitle("Health Tips").navigationBarHidden(false)
        }
    }
    
    struct HealthTipsDistanceView_Previews: PreviewProvider {
        static var previews: some View {
            HealthTipsDistanceView()
        }
    }
}

