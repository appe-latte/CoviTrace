//
//  VaccUploadView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 17/05/2021.
//

import SwiftUI

struct VaccUploadView: View {
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack{
            bgGreen()
            
            
            VStack {
                VStack{
                    Text("How to submit results")
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
//                            Text("If you require your QR code urgently, we offer a Priority service where your results will be processed within 4hrs. The fee for this service is £5.99 and can be made using the button below:")
//                            Text("")
                        }.font(.footnote)
                        
                        // MARK: Paypal
//                        VStack(alignment: .center){
//                            Button(action: {
//                                openURL(URL(string: "https://paypal.me/covitrace?locale.x=en_GB")!)
//                            }) {
//                                HStack{
//                                    Text("Pay with")
//                                        .font(.footnote)
//                                        .fontWeight(.semibold)
//                                    Image("paypal-logo")
//                                        .resizable()
//                                        .frame(width: 65, height: 45)
//                                        .scaledToFit()
//                                }
//                            }
//                            .foregroundColor(Color(red: 41 / 255, green: 151 / 255, blue: 216 / 255))
//                            .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 50)
//                            .background(Color(.white))
//                            .cornerRadius(30)
//                        }
                        
//                        VStack {
//                            Text("")
//                            Text("When paying for the Priority Service please include the following reference to you payment. ") + Text("Priority Vaccination Verification - xxx xxx (Full Name)").bold()
//                            Text("")
//                        }
//                        Spacer()
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


