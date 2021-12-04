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
    @State var userEmail = ""
    
    @EnvironmentObject var viewModel : AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            bgPurple()
            
            VStack (alignment: .center){
                HStack {
                    Text("Reset Password")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("dismiss")
                            .font(.custom("Avenir", size: 10))
                            .foregroundColor(purple)
                    }).frame(width: 40, height: 20)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                
                // MARK: User Email Text
                CustomTextField(text: $userEmail, placeholder: Text("Email"), imageName: "envelope")
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                    .keyboardType(.emailAddress).autocapitalization(.none)
                    .padding(.top, 10)
                
                Spacer()
                
                // MARK: "Reset" Button
                Button(action: {
                    passwordReset(withEmail: userEmail)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Reset Password")
                        .font(.custom("Avenir", size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }).frame(width: 150, height: 50)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(10)
            }.font(.subheadline)
                .padding(10)
        }.navigationBarTitle("Reset Password")
            .navigationBarTitleDisplayMode(.inline)
    }
}

func passwordReset(withEmail email: String, _ callback: ((Error?) -> ())? = nil){
    Auth.auth().sendPasswordReset(withEmail: email) { error in
        callback?(error)
    }
}
