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
                        Text("....")
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
    
    struct HealthTipsRestView_Previews: PreviewProvider {
        static var previews: some View {
            HealthTipsRestView()
        }
    }
}
