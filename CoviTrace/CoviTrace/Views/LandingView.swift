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
            GeometryReader { geo in
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
            }.edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    Spacer()
                        .frame(height: 50)
                    GeometryReader { geo in
                        VStack(alignment: .center) {
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
                        }.frame(width: geo.size.width, height: geo.size.height)
                    }
                    
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
                    }).buttonStyle(whiteButton())
                        .sheet(isPresented: $showSignUpSheetView) {
                            SignUpView()
                        }
                    
                    // MARK: "Login" Button
                    Button(action: {
                        self.showLoginSheetView.toggle()
                    }, label: {
                        Text("Login")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }).buttonStyle(greenButton())
                        .sheet(isPresented: $showLoginSheetView) {
                            LoginView()
                        }
                    
                    Text("Developed by: Appè Latte")
                        .font(.custom("Avenir", size: 12))
                        .foregroundColor(.white)
                }.padding(.bottom, 10)
            }
        }
    }
}
