//
//  HealthTipsMaskView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 01/03/2021.
//

import SwiftUI

struct HealthTipsMaskView: View {
    var body: some View {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    VStack{
                        Text("WEAR YOUR MASK")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                        Image("face-mask")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Text("Always wear your face mask when travelling outside and in all public spaces. Follow your local council or government regulations on social distancing by allowing at least a minimum of 1.5m between you and other people.")
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
    
    
    struct HealthTipsMaskView_Previews: PreviewProvider {
        static var previews: some View {
            HealthTipsMaskView()
        }
    }
}
