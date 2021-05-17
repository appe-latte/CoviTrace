//
//  VaccUploadView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 17/05/2021.
//

import SwiftUI

struct VaccUploadView: View {
    var body: some View {
        ZStack{
            bgGreen()
            
            
            VStack {
                VStack{
                    Text("Vaccination Information")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.top, 15)
                
                VStack(alignment:.center){
                    VStack{
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text("Send a scanned copy of your vaccination card along with a copy of your valid Government ID (if you are not yet verified) to: ") + Text("vaccination@covitrace.co.uk").bold()
                            Text("")
                            Text("The email subject line should read: ") + Text("'Vaccination Verification - xxx xxx (Full Name)'").bold()
                            Text("")
                            Text("Please allow upto 48hrs before your Vaccination QR Code is ready for use.")
                            Text("")
                            Text("If you require your QR code urgently, we offer a Priority service where your results will be processed within 4 hrs. The fee for this service is £5.99 and should be paid through PayPal to: ") + Text("paypal.me/covitrace").bold()
                            Text("")
                            Text("To use our Priority Service send an email with the subject line: ") + Text("Priority Vaccination Verification - xxx xxx (Full Name)").bold()
                        }.font(.footnote)
                        Spacer(minLength: 1)
                        
                        //MARK: Disclaimer
                        VStack(alignment: .leading) {
                            Text("* Please Note: ").bold() + Text("All Govt ID documents are deleted immediately after verification of the results and will not be stored on any of our systems.")
                            Text("")
                        }.font(.footnote)
                    }.foregroundColor(.white)
                    .lineLimit(nil)
                    .font(.footnote)
                    .padding(10)
                    Spacer()
                }.padding(5)
                
                Spacer()
            }
        }.navigationTitle("Add Vaccination Information")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VaccUploadView_Previews: PreviewProvider {
    static var previews: some View {
        VaccUploadView()
    }
}
