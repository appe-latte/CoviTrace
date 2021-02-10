//
//  HealthTipsWashView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/02/2021.
//

import SwiftUI

struct HealthTipsWashView: View {
    var body: some View {
//        NavigationView {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
                    .ignoresSafeArea()
                
                VStack(alignment:.center){
                    VStack{
                        Text("WASH YOUR HANDS")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                        Image("wash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Text("To aide in the prevention of virus transmission, it is advisable to constantly wash your hands with soap and water. A good 20 second wash will do and do make sure you wash between your fingers and the back of your hand properly.")
                            .foregroundColor(.white)
                            .lineLimit(nil)
                            .font(.title3)
                            .padding(5)
                    }
                    Spacer()
                }.padding(5)
                .frame(minHeight: 0, maxHeight: 800 )
            }.navigationBarTitle("Health Tips").navigationBarHidden(false)
//        }.edgesIgnoringSafeArea(.all)
        }
    }
    
    struct HealthTipsWashView_Previews: PreviewProvider {
        static var previews: some View {
            HealthTipsWashView()
        }
    }
}
