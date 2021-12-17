//
//  PasswordResetView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 24/05/2021.
//

import os
import SwiftUI
import Combine
import Firebase
import FirebaseAuth

struct PasswordResetView: View {
    @State var email = ""
    
    @EnvironmentObject var viewModel : AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack (alignment: .center){
                HStack {
                    Text("Reset Password")
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
                
                // MARK: User Email Text
                CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                    .padding(5)
                    .foregroundColor(purple)
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    .background(purple.opacity(0.1))
                    .cornerRadius(15)
                    .keyboardType(.emailAddress).autocapitalization(.none)
                    .padding(.top, 10)
                
                Spacer()
                
                // MARK: "Reset" Button
                Button(action: {
                    passwordReset(withEmail: email)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Reset Password")
                        .font(.custom("Avenir", size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }).buttonStyle(purpleButton())
                    .disabled((email != "") ? false : true)
                    .opacity((email != "") ? 1 : 0.6)
            }.font(.subheadline)
                .padding(10)
        }.background(bgWhite())
            .accentColor(purple)
    }
}

func passwordReset(withEmail email: String, _ callback: ((Error?) -> ())? = nil){
    Auth.auth().sendPasswordReset(withEmail: email) { error in
        callback?(error)
    }
}
