//
//  HowAppWorksView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 23/02/2021.
//

import SwiftUI

struct HowAppWorksView: View {
    var body: some View {
        
        ZStack
        {
            Background()
            ScrollView(.vertical) {
                
                VStack(alignment:.center){
                    VStack{
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text("How CoviTrace works")
                                .font(.title2)
                                .bold()
                            Text("The app will run in the background and will not disrupt any activites on your device. When in the close proximity of another user who has the CoviTrace app active, a handshake will occur where both devices will exchange random codes with each other whilst you are still in the close proximity with each other.")
                            Text("")
                            Text("These exchanged random codes will change frequently and cannot be used to identify you or your device type. These random codes will only be stored on your device for a 14 days and will automatically be deleted at the point of expiry.")
                            Text("")
                            Text("Location Permission")
                                .font(.title2)
                                .bold()
                            Text("CoviTrace does not store or track you in the background. The permission for your location is simply to get the user's location in order to retrieve the Covid-19 statistics for that location / County. This information is not stored on your device or our servers at all, ensuring your privcay at all times.")
                            Text("")
                        }.font(.subheadline)
                        
                        VStack(alignment: .leading) {
                            Text("What the app shares")
                                .font(.title2)
                                .bold()
                            Text("This app does not share any of your data without your explicit and written consent to us to release this. Requests for this can be made by email to: enquiry@covitrace.com")
                            Text("")
                            Text("When this written permission is given, the only informatoin that will be shared are the random codes generated by the app and nothing else.")
                            Text("")
                        }.font(.subheadline)
                        Spacer()
                    }.foregroundColor(.white)
                    .lineLimit(nil)
                    .font(.footnote)
                    .padding(10)
                    Spacer()
                }.padding(5)
                .frame(minHeight: 0, maxHeight: 800 )
            }
        }
    }
}

struct HowAppWorksView_Previews: PreviewProvider {
    static var previews: some View {
        HowAppWorksView()
    }
}