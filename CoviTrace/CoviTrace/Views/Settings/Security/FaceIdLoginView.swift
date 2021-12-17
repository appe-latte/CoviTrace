//
//  FaceIdLoginView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 25/10/2021.
//

import SwiftUI
import LocalAuthentication

struct FaceIdLoginView: View {
    @ObservedObject var appLockModel: AppLockViewModel
    @EnvironmentObject var authModel : AuthViewModel
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                HStack {
                    
                    // MARK: Logout Button
                    Button(action: {
                        authModel.signOut()
                    },
                           label: {
                        Text("Logout")
                            .font(.custom("Avenir", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(5)
                    })
                    
                    Spacer()
                    
                    // MARK: Unlock with Face ID
                    Button(action: {
                        appLockModel.appLockValidation()
                    },
                           label: {
                        Text("Unlock")
                            .font(.custom("Avenir", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(5)
                    })
                }.padding(.top, 75)
                
                Spacer()
                
                VStack(spacing: 10) {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .imageScale(.large)
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    
                    Text("Please unlock the app to continue.")
                        .font(.custom("Avenir", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(5)
                }
                
                Spacer()
//                    .frame(height: 150)
                
                
//                HStack {
//
//                    // MARK: Logout Button
//                    Button(action: {
//                        authModel.signOut()
//                    },
//                           label: {
//                        Text("Logout")
//                            .font(.custom("Avenir", size: 16))
//                            .fontWeight(.bold)
//                            .foregroundColor(.white)
//                            .padding(5)
//                    })
//
//                    Spacer()
//
//                    // MARK: Unlock with Face ID
//                    Button(action: {
//                        appLockModel.appLockValidation()
//                    },
//                           label: {
//                        Text("Unlock")
//                            .font(.custom("Avenir", size: 16))
//                            .fontWeight(.bold)
//                            .foregroundColor(.white)
//                            .padding(5)
//                    })
//                }.padding(.horizontal, 20)
            }
        }
    }
}
