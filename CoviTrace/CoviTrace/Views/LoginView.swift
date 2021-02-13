//
//  LoginView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI

struct LoginView: View {
    @State var userEmail = ""
    @State var userPassword = ""
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        
        NavigationView{
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                    Spacer()
                }
                
                VStack (alignment: .center){
                    Spacer()
                    
                    // MARK: User Email Text
                    CustomTextField(text: $userEmail, placeholder: Text("Email"), imageName: "envelope")
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading, 15)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(15)
                        .keyboardType(.emailAddress).autocapitalization(.none)
                    
                    // MARK: User Password Text
                    CustomSecureTextField(text: $userPassword, placeholder: Text("Password"))
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading, 15)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(15)
                    
                    // MARK: "Login" Button
                    Button(action: {
                        viewModel.userLogin(withEmail: userEmail, password: userPassword)
                    }, label: {
                        Text("Login")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading, 10)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(30)
                    
                    // MARK: "No Account"
                    NavigationLink(
                        destination: SignUpView()){
                        Text("Don't have an account?")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(Color(.white))
                            .padding(.top, 2)
                    }
                }.font(.subheadline)
                .padding(10)
            }
        }.navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
