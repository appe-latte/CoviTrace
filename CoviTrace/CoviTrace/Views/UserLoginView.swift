//
//  UserLogin.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/11/2021.
//

import SwiftUI
import Firebase

struct UserLoginView: View {
    @State var cellNum = ""
    @State var countryCode = ""
//    let countryCodeType = ["code", "+268", "+267", "+266", "+263", "+27"]
    let countryCodeType = ["code", "+27", "+263"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Background()
                VStack(spacing: 10){
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack(alignment:.center){
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    // MARK: Cellphone Number + Country Code
                    HStack{
                        Picker("code", selection: $countryCode) {
                            ForEach(countryCodeType, id: \.self) {
                                Text($0).bold()
                            }
                            .padding(5)
                            .foregroundColor(Color(.white))
                            .frame(width: 80, height: 50).padding(.leading,10)
                            .background(Color(.black).opacity(0.1))
                            .cornerRadius(10)
                        }.frame(width:80)
                        
                        TextField("Cell number", text: $cellNum)
                            .padding(5)
                            .foregroundColor(Color(.white))
                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                            .background(Color(.black).opacity(0.1))
                            .cornerRadius(10)
                            .keyboardType(.numberPad)
                    }.padding(.horizontal, 15)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    // MARK: "Login" Button
                    Button(action: {
                        //                    viewModel.userLogin(withEmail: userEmail, password: userPassword)
                        
                    }, label: {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }).frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                        .padding(.top, 2)
                        .disabled((countryCode != "" && cellNum != "") ? false : true)
                        .opacity((countryCode != "" && cellNum != "") ? 1 : 0.6)
                    
                    // MARK: "No Account"
                    NavigationLink(
                        destination: SignUpView()){
                            Text("Don't have an account?")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(Color(.white))
                                .padding(.top, 2)
                        }
                }
            }.navigationBarHidden(true)
                .navigationBarTitleDisplayMode(.inline)
        }.accentColor(Color.white)
    }
}
