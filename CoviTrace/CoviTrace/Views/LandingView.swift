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
            
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment:.center) {
                    Spacer()
                        .frame(height: 120)
                    VStack {
                        Circle()
                            .foregroundColor(Color.white)
                            .frame(width: 160, height: 160)
                            .clipShape(Circle())
                            .overlay(
                                Image("logo-icon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 140)
                                    .clipShape(Circle())
                            )
                        Text("Covitrace")
                            .foregroundColor(.white)
                            .font(.custom("Avenir", size: 32))
                            .fontWeight(.bold)
                    }.padding(.top, 20)
                    
                    Spacer()
                }
                
                VStack(spacing: 5) {
                    
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
                    }.buttonStyle(whiteButton())
                    
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
                    }.buttonStyle(greenButton())
                    
                    Text("Developed by: Appè Latte")
                        .font(.custom("Avenir", size: 12))
                        .foregroundColor(.white)
                }.padding(.bottom, 30)
                
                Spacer()
                    .frame(height: 50)
            }
        }
    }
}
