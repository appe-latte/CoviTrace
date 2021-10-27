//
//  OtpVerificationView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 07/10/2021.
//

import SwiftUI

struct OtpVerificationView: View {
    @State var otpCode : String = ""
    
    var body: some View {
        ZStack {
            Background()
            VStack(alignment: .center) {
                
                // MARK: View Heading
                Text("Enter Verification Code")
                    .font(.system(size: 26).bold())
                    .foregroundColor(Color(.white))
                    .padding(.trailing, 90)
                
                // MARK: Code entry textfields
                TextField(otpCode, text: $otpCode)
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                    .padding(.top, 20)
                
                Text("Please enter the code that has been sent to your mobile phone to complete verification and proceed to the final stage of registration.")
                    .foregroundColor(.white)
                    .font(.system(size: 10))
                    .padding(.horizontal, 5)
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 30)
                
                Spacer()
                
                // MARK: "verify" button
                Button(
                    action: {
                        
                    },
                    label: {
                        Text("VERIFY")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading, 15)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(10)
            }
        }
    }
}

struct OtpVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        OtpVerificationView()
    }
}
