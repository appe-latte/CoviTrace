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
            GeometryReader { geo in
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
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
                
                HStack {
                    
                    // MARK: Logout Button
                    Button(action: {
                        authModel.signOut()
                    },
                           label: {
                        VStack {
                            Image("turn-off-w")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(1)
                            Text("Logout")
                                .font(.custom("Avenir", size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }.padding(5)
                    })
                    
                    Spacer()
                    
                    // MARK: Unlock with Face ID
                    Button(action: {
                        appLockModel.appLockValidation()
                    },
                           label: {
                        VStack {
                            Image("unlock-w")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(1)
                            Text("Unlock")
                                .font(.custom("Avenir", size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }.padding(5)
                    })
                }.padding(.horizontal, 20)
            }
        }
    }
}
