//
//  FaceIdLoginView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 25/10/2021.
//

import SwiftUI

struct FaceIdLoginView: View {
    @ObservedObject var appContext: AppContext
    @EnvironmentObject var authModel : AuthViewModel
    
    var body: some View {
        ZStack {
            Background()
            VStack(alignment: .center) {
                Spacer()
                
                VStack(spacing: 10) {
                    Image(systemName: "lock.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                    Text("Please unlock the app to continue.")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(5)
                }
                
                Spacer()
                
                HStack {
                    // MARK: Logout Button
                    Button(action: {
                        
                        // add code here to logout
                    },
                           label: {
                        
                        Text("Logout")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .font(.body)
                            .padding(5)
                        
                    })
                    
                    Spacer()
                    
                    // MARK: FaceID Login Button
                    Button(action: {
                        appContext.requestBiometricUnlock()
                    },
                           label: {
                        
                        Text("Unlock")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .font(.body)
                            .padding(5)
                    })
                }.padding(.horizontal, 30)
            }
        }
    }
}
