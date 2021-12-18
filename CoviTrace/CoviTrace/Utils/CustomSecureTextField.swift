//
//  CustomSecureTextField.swift
//  CoviTrace
//
//  Created by Appè Latte on 08/02/2021.
//

import SwiftUI

struct CustomSecureTextField: View {
    @Binding var text: String
    let placeholder: Text
    
    var body: some View {
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack(alignment: .leading){
            if text.isEmpty{
                placeholder
                    .foregroundColor(purple)
                    .padding(.leading, 40)
                    .font(.custom("Avenir", size: 14).bold())
            }
            
            HStack(spacing: 16){
                Image("padlock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(purple)
                    .padding(.leading, 10)
                
                SecureField("", text: $text).textContentType(.newPassword)
                    .font(.custom("Avenir", size: 14).bold())
            }
        }
    }
}
