//
//  FaceIdLoginView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 25/10/2021.
//

import SwiftUI

struct FaceIdLoginView: View {
    @ObservedObject var appContext: AppContext
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                Spacer(minLength: 10)
                
                Image(systemName: "faceid")
                    .resizable()
                    .frame(width: 150, height: 150)
                
                Spacer()
                
                Button(action: {
                    appContext.requestBiometricUnlock()
                },
                       label: {
                    HStack {
                        Text("Login")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                        .padding(5)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                })
                
                Spacer()
            }
        }
    }
}
