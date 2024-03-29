//
//  CustomSecureTextField.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI

struct CustomSecureTextField: View {
    @Binding var text: String
    let placeholder: Text
    
    var body: some View {
        ZStack(alignment: .leading){
            if text.isEmpty{
                placeholder
                    .foregroundColor(Color(.white))
                    .padding(.leading, 40)
                    .font(.footnote)
            }
            
            HStack(spacing: 16){
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.white))
                
                SecureField("", text: $text).textContentType(.newPassword)
            }
        }
    }
}
