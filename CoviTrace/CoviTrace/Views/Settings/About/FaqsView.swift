//
//  FaqsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 19/05/2021.
//

import SwiftUI

struct FaqsView: View {
    let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
    
    var body: some View {
        ScrollView(.vertical) {
            ZStack {
                VStack(alignment: .leading, spacing: 10){
                    Group {
                        Text("What information do you require")
                            .font(.custom("Avenir", size: 12))
                            .fontWeight(.bold)
                        Text("To register your account within the app we require your first and last name, vaild email address and contact telephone number (mobile). For the vaccination card, we require all the information written on your Government issued Vaccination card.").lineLimit(nil)
                        Text("\(Text("Please Note:").bold()) that we also require your Government issued ID number to ensure the integrity of the uploaded information and to ensure that the information you've entered genuinely belongs to you. ").lineLimit(nil)
                        Text("Does the app store or track my location")
                            .font(.custom("Avenir", size: 12))
                            .fontWeight(.bold)
                        Text("The Check-in feature will only store a record of your present location to help you keep a record of your movement for potential contact-tracing in the unfortunate event that you contract the Covid-19 virus. For venues and buildings, the Check-in feature will help keep a record of the number of attendees for that particular event.").lineLimit(nil)
                        Text("Why should I upload my Vaccination Card?")
                            .font(.custom("Avenir", size: 12))
                            .fontWeight(.bold)
                        Text("By uploading a copy of your vaccination card onto the app you will be able to quickly provide proof of the authenticity of the results when requested by any Government official.").lineLimit(nil)
                    }
                    
                    Spacer()
                        .frame(height: 2)
                    
                    Group {
                        Text("Why should I email a copy of my Vaccination Card?")
                            .font(.custom("Avenir", size: 12))
                            .fontWeight(.bold)
                        Text("By emailing a copy of your Vaccination Card to us, we are able to authenticate the vaccination information you uploaded and add a \(Text("verifed").bold()) status to your QR coded pass. This will give whoever requests to see these results, confidence in the legitimacy of the information they are shown.").lineLimit(nil)
                        Text("Please Note: we do keep copies of these and will immediately delete them from our servers upon successful verification.").lineLimit(nil)
                        Text("What data do you store?")
                            .font(.custom("Avenir", size: 12))
                            .fontWeight(.bold)
                        Text("We only store the information uploaded by you within the app and NONE of this information will be shared without your explicit consent.").lineLimit(nil)
                    }
                    
                    Spacer()
                }.frame(width: UIScreen.main.bounds.size.width - 40, height: UIScreen.main.bounds.size.height - 1)
                    .foregroundColor(purple)
                    .font(.custom("Avenir", size: 10))
                    .multilineTextAlignment(.leading)
                    .padding(.top, 5)
            }.navigationBarTitle("Frequently Asked Questions").navigationBarHidden(false)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

