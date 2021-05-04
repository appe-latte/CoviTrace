//
//  HealthTipsFoodView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/02/2021.
//

import SwiftUI

struct HealthTipsFoodView: View {
    var body: some View {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    VStack{
                        Text("EAT HEALTHY FOODS")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                        Image("food")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Text("To give your immune system a boost, eat healthy as much as possible. Foods with Vitamins (C, D & E), Zinc, Protein and all green vegetables. Drinking a mixture of Lemon, Ginger & Honey or Black Seed Oil in a glass of warm water is said to be helpful in the prevention of mucus development and boosts your immune system.")
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
    
    struct HealthTipsFoodView_Previews: PreviewProvider {
        static var previews: some View {
            HealthTipsFoodView()
        }
    }
}
