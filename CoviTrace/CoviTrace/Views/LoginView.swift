//
//  LoginView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI
import os
import Combine
import FirebaseAuth

struct LoginView: View {
    @State var email = ""
    @State var userPassword = ""
    @State private var isLoggedIn : Bool = false
    @State var showPwdResetSheetView = false
    @State var showSignUpSheetView = false
    
    // MARK: Objects
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            VStack (spacing: 2){
                HStack {
                    Text("User Login")
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
                
                VStack {
                    // MARK: User Email Text
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding(5)
                        .foregroundColor(purple)
                        .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                        .background(purple.opacity(0.1))
                        .cornerRadius(10)
                        .keyboardType(.emailAddress).autocapitalization(.none)
                    
                    // MARK: User Password Text
                    CustomSecureTextField(text: $userPassword, placeholder: Text("Password"))
                        .padding(5)
                        .foregroundColor(purple)
                        .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                        .background(purple.opacity(0.1))
                        .cornerRadius(10)
                }
                
                // MARK: "Password Recovery"
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.showPwdResetSheetView = true
                    }, label: {
                        Text("Forgot Password?")
                            .font(.custom("Avenir", size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(purple)
                            .padding(.top, 5)
                            .padding(.horizontal, 20)
                    }).sheet(isPresented: $showPwdResetSheetView){
                        PasswordResetView()
                    }
                }
                
                Spacer()
                
                // MARK: "Login" Button
                Button(action: {
                    viewModel.userLogin(withEmail: email, password: userPassword)
                }, label: {
                    Text("Login")
                        .font(.custom("Avenir", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }).buttonStyle(purpleButton())
                    .padding(.top, 2)
                    .padding(.bottom, 10)
                    .disabled((email != "" && userPassword != "") ? false : true)
                    .opacity((email != "" && userPassword != "") ? 1 : 0.6)
                    .alert(isPresented: $viewModel.isError, content: {
                        Alert(title: Text("Login Error"), message: Text(viewModel.errorMsg))
                    })
            }
        }.background(bgWhite())
            .accentColor(purple)
    }
}
