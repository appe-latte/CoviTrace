//
//  AboutView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 19/05/2021.
//

import SwiftUI

struct AboutView: View {
    let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
    
    var body: some View {
        ScrollView(.vertical) {
            ZStack {
                VStack {
                    VStack(alignment: .leading, spacing: 5){
                        Group {
                            Text("How Covitrace works?")
                                .font(.custom("Avenir", size: 12))
                                .fontWeight(.bold)
                            Text("Download and install the Covitrace app onto your device.").lineLimit(nil)
                            Text("Register your details and upload your vaccination card for validation.").lineLimit(nil)
                            Text("When your Covid-19 vaccination status is required, simply open the app and present your secure 2D-coded QR code for scanning.").lineLimit(nil)
                            Text("Use Covitrace to verify event attendees or those guests entering your building. A quick scan of the Qr code will speed up entry, no more long queues as you wait to enter!")
                                .lineLimit(nil)
                        }
                        
                        Spacer()
                            .frame(height: 2)
                        
                        Group {
                            Text("Why choose Covitrace?")
                                .font(.custom("Avenir", size: 12))
                                .fontWeight(.bold)
                            Text("Say goodbye to print out's and .pdf copies when you travel.").lineLimit(nil)
                            Text("Simple, clear interface for ease of use and quick usage.").lineLimit(nil)
                            Text("Make your events safe, quick & easy to enter by using Covitrace to check User Vaccine cards.")
                                .lineLimit(nil)
                            Text("With Covitrace you can quickly check visitors and staff into your office or building. No need for paper and registration processes at the point of entry!")
                                .lineLimit(nil)
                            Text("Covitrace will NOT share any of your personal information with outside sources or third parties without your explicit, written consent. YOU are in total control of your information and you can share when you decide to!")
                                .lineLimit(nil)
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(purple)
                    .font(.custom("Avenir", size: 10))
                    .multilineTextAlignment(.leading)
                    .padding(.top, 5)
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40)
            }.navigationBarTitle("About Covitrace").navigationBarHidden(false)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
