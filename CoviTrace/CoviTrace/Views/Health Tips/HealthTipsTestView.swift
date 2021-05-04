//
//  HealthTipsTestView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 04/05/2021.
//

import SwiftUI

struct HealthTipsTestView: View {
    var body: some View {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    VStack{
                        Text("TAKE REGULAR COVID TESTS")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                        Image("test")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Text("If you have not been vaccinated, getting regular testing and following government guidelines on keeping safe will go a long way in ensuring you remain safe. ")
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
}

struct HealthTipsTestView_Previews: PreviewProvider {
    static var previews: some View {
        HealthTipsTestView()
    }
}
