//
//  AboutAppView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 25/02/2021.
//

import SwiftUI

struct AboutAppView: View {
    var body: some View {
        ZStack
        {
            Background()
            ScrollView(.vertical) {
                
                VStack(alignment:.center){
                    VStack{
                        Text("About This App")
                            .font(.title)
                            .bold()
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(15)
                        
                        VStack(alignment: .leading) {
                            Text("Location Check-in")
                                .font(.title2)
                                .bold()
                            Text("The 'CHECK-IN' function will only save your approximate location and the date. For example, 'Regal Gelato | 12-01'. The time or exact location will not be logged or saved ensuring your continued privacy. This data will only remain on our servers for a maximum of 14 days, after which they will be deleted.")
                            Text("")
                            Text("Test Results")
                                .font(.title2)
                                .bold()
                            Text("Each user can save their test results and keep a log of any PCR test results taken or log the date and location the vaccination doses taken. By logging and saving the data on the device, the results will be easily and quickly accessible when required. The certificate can either be uploaded in (.pdf) format or a screenshot, as long it shows the administering body of the test and the date it was issued. This should tie in with the information supplied when entering the details in the text fields.")
                            Text("")
                            Text("Your test results and uploaded certificates are stored on a secure server and will not be available to anyone but the verified user.")
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

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView()
    }
}
