//
//  HowLocationView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 19/05/2021.
//

import SwiftUI

struct HowLocationView: View {
    var body: some View {
        ScrollView(.vertical) {
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    Spacer()
                    VStack{
                        Text("'CHECK-IN'")
                            .bold()
                            .font(.body)
                        Text("")
                        Text("The 'CHECK-IN' function will only save your approximate location and the date when the button is pressed. For example: 'Regal Gelato | 12-01-2021'. The time or exact location will not be logged or saved ensuring your continued privacy.")
                            .lineLimit(nil)
                        Text("")
                        Text("The information from your check-ins can only be viewed by the Authorised User only and cannot be shared. If you require any check-in information to be removed please send an email to: admin@covitrace.co.uk with the subject line:") + Text("'Check-in Removal'").bold()
                        Text("")
                        Text("Provide the date and locations you would require removed from your records.")
                    }
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(5)
                    .multilineTextAlignment(.leading)
                    
                    VStack{
                        Text("Does the app track you?")
                            .bold()
                            .font(.body)
                        Text("")
                        Text("CoviTrace does NOT track you in the background nor do we collect information regarding your device's location. The permission for your location is simply to log your location for the 'Check-in' feature, that stores a record of your location at the precise moment the button was pressed.")
                            .lineLimit(nil)
                        Text("")
                        Text("The information from your check-ins can only be viewed by the Authorised User only and cannot be shared. If you require any check-in information to be removed please send an email to: admin@covitrace.co.uk with the subject line:") + Text("'Check-in Removal'").bold()
                        Text("")
                        Text("Provide the date and locations you would require removed from your records.")
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
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
