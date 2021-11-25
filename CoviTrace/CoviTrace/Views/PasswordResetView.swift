//
//  PasswordResetView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 24/05/2021.
//

import SwiftUI
import Firebase
import os
import Combine

struct PasswordResetView: View {
    @State var userEmail = ""
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        ZStack {
            Background()
            
            VStack (alignment: .center){
                // MARK: View Heading
                Text("Reset Password")
                    .font(.custom("Avenir", size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(Color(.white))
                    .padding(.trailing, 150)
                
                // MARK: User Email Text
                CustomTextField(text: $userEmail, placeholder: Text("Email"), imageName: "envelope")
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                    .keyboardType(.emailAddress).autocapitalization(.none)
                
                Spacer()
                
                // MARK: "Reset" Button
                Button(action: {
                    
                }, label: {
                    Text("Reset Password")
                        .font(.custom("Avenir", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }).frame(width: UIScreen.main.bounds.size.width - 40, height: 50)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(10)
                
            }.font(.subheadline)
                .padding(10)
        }.navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
    }
}
