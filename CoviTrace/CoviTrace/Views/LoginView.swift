//
//  LoginView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI
import os
import Combine

struct LoginView: View {
    @State var email = ""
    @State var userPassword = ""
    @State private var isLoggedIn : Bool = false
    @State var showPwdResetSheet = false
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                bgGrad()
                
                VStack (spacing: 2){
                    
                    VStack {
                        // MARK: User Email Text
                        CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                            .padding(5)
                            .foregroundColor(Color(.white))
                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                            .background(Color(.white).opacity(0.1))
                            .cornerRadius(10)
                            .keyboardType(.emailAddress).autocapitalization(.none)
                        
                        // MARK: User Password Text
                        CustomSecureTextField(text: $userPassword, placeholder: Text("Password"))
                            .padding(5)
                            .foregroundColor(Color(.white))
                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                            .background(Color(.white).opacity(0.1))
                            .cornerRadius(10)
                    }
                    
                    // MARK: "Password Recovery"
                    Button(action: {
                        self.showPwdResetSheet.toggle()
                    }, label: {
                        Text("Forgot Password?")
                            .font(.custom("Avenir", size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(Color(.white))
                            .padding(2)
                            .padding(.leading, 175)
                    }).sheet(isPresented: $showPwdResetSheet){
                        PasswordResetView()
                    }
                    
                    Spacer()
                    
                    // MARK: "Login" Button
                    Button(action: {
                        viewModel.userLogin(withEmail: email, password: userPassword)
                    }, label: {
                        Text("Login")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }).frame(width: 150, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.top, 2)
                        .alert(isPresented: $viewModel.isError, content: {
                            Alert(title: Text("Login Error"), message: Text(viewModel.errorMsg))
                        })
                    
                    // MARK: "No Account"
                    NavigationLink(
                        destination: SignUpView()){
                            Text("Don't have an account?")
                                .font(.custom("Avenir", size: 12))
                                .fontWeight(.bold)
                                .foregroundColor(Color(.white))
                                .padding(.top, 2)
                        }
                }.font(.subheadline)
            }
        }.accentColor(.white)
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }
}
