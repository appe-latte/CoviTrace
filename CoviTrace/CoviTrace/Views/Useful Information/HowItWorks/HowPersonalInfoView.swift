//
//  HowPersonalInfoView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 19/05/2021.
//

import SwiftUI

struct HowPersonalInfoView: View {
    var body: some View {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    Spacer()
                    VStack{
                        Text("Do we keep your personal data?")
                            .bold()
                            .font(.body)
                        Text("")
                        Text("Covitrace Ltd. will NOT keep any sensitive, personal data on any of our servers. The ID is required to authenticate the User and valid their results against the individual in order to maintainn the integrity of the information.")
                            .lineLimit(nil)
                        Text("")
                        Text("The only information kept on our servers will be your email address, first and last name, which we will not transfer or allow access to this information without your prior written consent.")
                        Text("")
                        Text("Your information will also not be sold to any third parties without having your prior consent.")
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

