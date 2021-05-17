//
//  UploadResultsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 17/05/2021.
//

import SwiftUI

struct UploadResultsView: View {
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
                            Text("Verification of results")
                                .font(.title2)
                                .bold()
                            Text("")
                            Text("Vaccination Results:")
                                .font(.title3)
                                .bold()
                            Text("Send a scanned copy of your vaccination card along with a copy of your valid Government ID (if you are not yet verified) to: ") + Text("vaccination@covitrace.co.uk").bold()
                            Text("")
                            Text("The email subject line should read: ") + Text("'Vaccination Verification - xxx xxx (Full Name)'").bold()
                            Text("")
                        }.font(.subheadline)
                        
                        VStack(alignment: .leading) {
                            Text("If you require your QR code urgently, we offer a Priority service where your results will be processed within 4 hrs. The fee for this service is £5.99 and should be paid through PayPal to: ") + Text("paypal.me/covitrace").bold()
                            Text("")
                            Text("To use our Priority Service send an email with the subject line: ") + Text("Priority Vaccination Verification - xxx xxx (Full Name)").bold()
                            Text("")
                        }.font(.subheadline)
                        
                        VStack(alignment: .leading) {
                            Text("Test Results:")
                                .font(.title3)
                                .bold()
                            Text("Send a scanned copy of your test results along with a copy of your valid Government ID (if you are not yet verified) to: ") + Text("results@covitrace.co.uk").bold()
                            Text("")
                            Text("Please allow upto 48hrs before your test results or vaccination information can be verified.")
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

struct UploadResultsView_Previews: PreviewProvider {
    static var previews: some View {
        UploadResultsView()
    }
}
