//
//  HowRegistrationView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 19/05/2021.
//

import SwiftUI

struct HowRegistrationView: View {
    var body: some View {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    Spacer()
                    VStack{
                        Text("User Registration")
                            .bold()
                        Text("")
                        Text("The app is free to use and requires the User's full name and email address to complete the basic registration process. Upon successful registration the User will have full access to the app and can begin to use all the available services.")
                            .lineLimit(nil)
                        Text("")
                        Text("User Verification")
                            .bold()
                        Text("")
                        Text("In order to validate any uploaded test results and to have a vaccination QR code generated, we would require a copy of your Government Identification which clearly shows your photograph. This will be used to verify your identity and would allow us to validate all your uploads as authentic.")
                            .lineLimit(nil)
                        Text("")
                        Text("NOTE:").bold() + Text("Ensure that your uploaded image is identical to that of your Govt ID or your pass may not be accepted when shown for travel purposes.")                        
                    }
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(5)
                    .multilineTextAlignment(.leading)
                    
                    VStack(alignment: .leading){
                        Text("Acceptable forms of Identification")
                            .bold()
                        Text("")
                        Text("• Valid Passport")
                        Text("• Driver's Licence")
                        Text("• Government issued Identification")
                        Text("• Military ID cards")
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

