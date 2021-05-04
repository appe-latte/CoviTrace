//
//  HealthTipsCleanView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 04/05/2021.
//

import SwiftUI

struct HealthTipsCleanView: View {
    var body: some View {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    VStack{
                        Text("KEEP ALL SURFACES AND CONTACT AREAS CLEAN")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                        Image("clean")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Text("Keeping all surfaces and contact areas such as door handles and light switches clean will go a long way in stemming any potential spread or contraction of the virus.")
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
    }}

struct HealthTipsCleanView_Previews: PreviewProvider {
    static var previews: some View {
        HealthTipsCleanView()
    }
}
