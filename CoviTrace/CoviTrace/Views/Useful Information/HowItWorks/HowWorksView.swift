//
//  HowWorksView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 19/05/2021.
//

import SwiftUI

struct HowWorksView: View {
    var body: some View {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    VStack{
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                        Text("The app will run in the background and will not disrupt any activites on your device. When in the close proximity of another user who has the CoviTrace app active, a handshake will occur where both devices will exchange random codes with each other whilst you are still in the close proximity with each other.")
                            .lineLimit(nil)
                        Text("")
                        Text("These exchanged random codes will change frequently and cannot be used to identify you or your device type. These random codes will only be stored on your device for a 14 days and will automatically be deleted at the point of expiry.")
                            .lineLimit(nil)
                        Text("")
                        Text("* This feature will be available in a future version of the app.")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(5)
                    .multilineTextAlignment(.leading)
                    
                    Spacer()
                }.padding(5)
                .frame(minHeight: 0, maxHeight: 800 )
            }.navigationBarTitle("How Covitrace Works").navigationBarHidden(false)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
