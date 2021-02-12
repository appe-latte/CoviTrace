//
//  HealthTipsCoverView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/02/2021.
//

import SwiftUI

struct HealthTipsCoverView: View {
    var body: some View {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    VStack{
                        Text("COVER UP WHEN YOU SNEEZE")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                        Image("sneeze")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Text("If you have to sneeze or cough, use some tissue paper and then dispose of it straight away. If you do not have tissue at hand, use the inside of your forearm. It is best not to cough into your hand, unless your are able to wash them immediately, as the bacteria may be spread when you touch objects soon after.")
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
    
    struct HealthTipsCoverView_Previews: PreviewProvider {
        static var previews: some View {
            HealthTipsCoverView()
        }
    }
}
