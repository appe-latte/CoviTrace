//
//  LandingView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI
import Combine

struct LandingView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                bgPurple()
                VStack(alignment:.center){
                    VStack{
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                        Text("CoviTrace")
                            .foregroundColor(.white)
                            .font(.custom("Avenir", size: 24))
                            .fontWeight(.bold)
                    }.padding(.top, 20)
                    
                    Spacer()
                }
                
                VStack(spacing: 10) {
                    
                    Spacer()
                    
                    //MARK: "Register" Button
                    NavigationLink(
                        destination: SignUpView()){
                            Text("Register")
                                .font(.custom("Avenir", size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        }
                        .frame(width: 150, height: 50)
                        .background(Color(.white))
                        .cornerRadius(10)
                    
                    // MARK: "Login" Button
                    NavigationLink(
                        destination: LoginView()){
                            Text("Login")
                                .font(.custom("Avenir", size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(width: 150, height: 50)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                }.padding(.bottom, 20)
                
            }.navigationBarHidden(true)
                .accentColor(Color.white)
            
        }
        
    }
}
