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
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geo in
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height)
                }.edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        //                        Spacer()
                        //                            .frame(height: 50)
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
                    }.padding(.bottom, 50)
                    
                    VStack(spacing: 5) {
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: LoginView()) {
                                Text("Enter")
                                    .font(.custom("Avenir", size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                            }.buttonStyle(greenButton())
                        
                        Text("by: Appè Latte")
                            .font(.custom("Avenir", size: 10))
                            .foregroundColor(.white)
                    }.padding(.bottom, 10)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
