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
                    .font(.system(size: 26).bold())
                    .foregroundColor(Color(.white))
                    .padding(.trailing, 150)
                
                // MARK: User Email Text
                CustomTextField(text: $userEmail, placeholder: Text("Email"), imageName: "envelope")
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                    .keyboardType(.emailAddress).autocapitalization(.none)
                
                Spacer()
                
                // MARK: "Reset" Button
                Button(action: {
                    
                }, label: {
                    Text("Reset Password")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading, 15)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                
            }.font(.subheadline)
                .padding(10)
        }
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView()
    }
}
