//
//  FaqsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 19/05/2021.
//

import SwiftUI

struct FaqsView: View {
    @State var isHowWorksExpanded = false
    @State var isWhyAppExpanded = false
    @State var isFaqExpanded = false
    @State var isFaqExpanded_data = false
    @State var isFaqExpanded_qr = false
    @State var isFaqExpanded_upload = false
    @State var isFaqExpanded_location = false
    @State var isFaqExpanded_id = false
    @State var rowHeight = 50.0
    
    var body: some View {
        ZStack {
            //            NavigationView {
            Form {
                Section {
                    //                VStack {
                    // How app works
                    DisclosureGroup("How the app works?", isExpanded: $isHowWorksExpanded) {
                        VStack(alignment: .leading) {
                            Text("• Download and install the Covitrace app.").lineLimit(nil)
                            Text("• Register your details and upload your vaccination card for validation.").lineLimit(nil)
                            Text("• You will automatically receive a QR code.").lineLimit(nil)
                            Text("• When your Covid-19 vaccination status is required, simply open the app and present your 2D- QR code for scanning.")
                                .lineLimit(nil)
                            Text("• Use Covitrace to verify event attendees or those guests entering your building and office park. A quick scan of the QR code will speed up access control.").lineLimit(nil)
                            Text("• Our app allows you a quick, easy, digital solution to check consumers Covid-19 vaccination data for crowd and access control.").lineLimit(nil)
                        }.font(.custom("Avenir", size: 11))
                    }
                    .foregroundColor(purple)
                    .font(.custom("Avenir", size: 13).bold())
                    .multilineTextAlignment(.leading)
                    
                    // Why choose covitrace
                    DisclosureGroup("Why choose this app?", isExpanded: $isWhyAppExpanded) {
                        VStack(alignment: .leading) {
                            Text("• A digital vaccination card on your smartphone, accessible with a secure QR code.").lineLimit(nil)
                            Text("• A simple, quick, easy and digitally secure tool to access your vaccination data.").lineLimit(nil)
                            Text("• A digital solution to check and verify the vaccination cards of visitors, staff, event goers and guests at access control points.")
                                .lineLimit(nil)
                            Text("• Our app allows you a quick and easy digital solution to check vaccination cards for entry into your office block, residential complex and event.")
                                .lineLimit(nil)
                        }.font(.custom("Avenir", size: 11))
                    }
                    .foregroundColor(purple)
                    .font(.custom("Avenir", size: 13).bold())
                    .multilineTextAlignment(.leading)
                    
                    // FAQ Section:
                    DisclosureGroup("What data do you store?", isExpanded: $isFaqExpanded_data) {
                        VStack(alignment: .leading) {
                            Text("We only store information uploaded by you on the app and none of this information is shared without your explicit consent.").lineLimit(nil)
                        }.font(.custom("Avenir", size: 11))
                    }
                    .foregroundColor(purple)
                    .font(.custom("Avenir", size: 13).bold())
                    .multilineTextAlignment(.leading)
                    
                    DisclosureGroup("How do I get the QR code?", isExpanded: $isFaqExpanded_qr) {
                        VStack(alignment: .leading) {
                            Text("The QR code is automatically generated when your information has been uploaded. However to have these verified you'll need to send us a copy of your vaccination card in .pdf / .png format to: verify@covitrace.co.za").lineLimit(nil)
                        }.font(.custom("Avenir", size: 11))
                    }
                    .foregroundColor(purple)
                    .font(.custom("Avenir", size: 13).bold())
                    .multilineTextAlignment(.leading)
                    
                    DisclosureGroup("Why should I upload my Vaccination Card?", isExpanded: $isFaqExpanded_upload) {
                        VStack(alignment: .leading) {
                            Text("Uploading your vaccination card to the app enables you to quickly provide proof of vaccination and authenticity of your results when requested by any Government official.").lineLimit(nil)
                        }.font(.custom("Avenir", size: 11))
                    }
                    .foregroundColor(purple)
                    .font(.custom("Avenir", size: 13).bold())
                    .multilineTextAlignment(.leading)
                    
                    DisclosureGroup("Does the app track me or store my location?", isExpanded: $isFaqExpanded_location) {
                        VStack(alignment: .leading) {
                            Text("The Check-in feature will only store your present location to help you keep a record of your movement for potential contact-tracing if you contract the Covid-19 virus. For venues and buildings, the Check-in feature will help keep a record of the number of attendees for that particular event.").lineLimit(nil)
                        }.font(.custom("Avenir", size: 11))
                    }
                    .foregroundColor(purple)
                    .font(.custom("Avenir", size: 13).bold())
                    .multilineTextAlignment(.leading)
                    
                    DisclosureGroup("Do you keep my govt ID info on file", isExpanded: $isFaqExpanded_id) {
                        VStack(alignment: .leading) {
                            Text("We do NOT keep or store any copies of your Government ID, we simply require these for verification purposes. Once we have verified your identity against your uploaded results we will immediately delete your ID from our system.")
                        }.font(.custom("Avenir", size: 11))
                    }
                    .foregroundColor(purple)
                    .font(.custom("Avenir", size: 13).bold())
                    .multilineTextAlignment(.leading)
                }
            }
            .environment(\.defaultMinListRowHeight, rowHeight)
        }
        .navigationTitle("About")
        .accentColor(purple)
    }
}

