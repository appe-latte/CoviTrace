//
//  LandingView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI
import Combine

struct LandingView: View {
    @State var showSignUpSheetView = false
    @State var showLoginSheetView = false
    
    var body: some View {
        ZStack {
            bgGrad()
            VStack(alignment:.center){
                VStack{
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                    Text("CoviTrace")
                        .foregroundColor(.white)
                        .font(.custom("Avenir", size: 32))
                        .fontWeight(.bold)
                }.padding(.top, 20)
                
                Spacer()
            }
            
            VStack(spacing: 10) {
                
                Spacer()
                
                //MARK: "Register" Button
                Button(action: {
                    self.showSignUpSheetView.toggle()
                }, label: {
                    Text("Register")
                        .font(.custom("Avenir", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                }).sheet(isPresented: $showSignUpSheetView) {
                    SignUpView()
                }.frame(width: 150, height: 50)
                    .background(Color(.white))
                    .cornerRadius(10)
                
                // MARK: "Login" Button
                Button(action: {
                    self.showLoginSheetView.toggle()
                }, label: {
                    Text("Login")
                        .font(.custom("Avenir", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }).sheet(isPresented: $showLoginSheetView) {
                    LoginView()
                }.frame(width: 150, height: 50)
                    .background(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                    .cornerRadius(10)
            }.padding(.bottom, 20)
        }
    }
}
