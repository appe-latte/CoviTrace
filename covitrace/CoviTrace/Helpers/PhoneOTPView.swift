//
//  PhoneOTPView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 05/01/2022.
//

import os
import SwiftUI
import Combine
import Firebase
import FirebaseAuth
import MapKit
import AlertToast

struct PhoneOTPView: View {
    @State var phoneOTP = ""
    @EnvironmentObject  var viewModel : AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    @State  var showCharacterErrorAlert = false
    var characterLimit = 6
    
    @Binding var verificationID: String
    
    var body: some View {
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            VStack (alignment: .center){
                HStack {
                    Text("Verification")
                        .foregroundColor(purple)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("close-p")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }).padding(5)
                        .clipShape(Circle())
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                
                // MARK: Phone OTP Text
                TextField("000000", text: $phoneOTP)
                    .frame(height: 50)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
                    .foregroundColor(purple)
                    .background(purple.opacity(0.1))
                    .multilineTextAlignment(.center)
                    .font(.custom("Avenir", size: 40).bold())
                    .cornerRadius(15)
                    .onReceive(self.phoneOTP.publisher.collect()) {
                        let phoneOTPString = String($0.prefix(characterLimit))
                        if self.phoneOTP != phoneOTPString {
                            self.phoneOTP = phoneOTPString
                        }
                    }
                
                Spacer()
                
                // MARK: "Verify Button" Button
                Button(action: {
                    if self.phoneOTP.count < 6 {
                        self.showCharacterErrorAlert = true
                    } else {
                        self.viewModel.verifyOTPAndSignIn(verificationID: self.verificationID, phoneOTP: phoneOTP)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("Confirm")
                        .font(.custom("Avenir", size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }).buttonStyle(purpleButtonLong())
                    .disabled((phoneOTP != "") ? false : true)
                    .opacity((phoneOTP != "") ? 1 : 0.6)
                    .toast(isPresenting: $showCharacterErrorAlert){
                        AlertToast(displayMode: .alert, type: .error(Color.red), title: "Invalid OTP", subTitle: "You have entered less than 6 digits")
                    }
                
            }.font(.subheadline)
                .padding(10)
        }.background(bgWhite())
            .accentColor(purple)
    }
}
