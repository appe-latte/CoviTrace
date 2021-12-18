//
//  SimpleTextField.swift
//  CoviTrace
//
//  Created by Appè Latte on 13/02/2021.
//

import SwiftUI

struct SimpleTextField: View {
    @Binding var text: String
    let placeholder: Text
    
    var body: some View {
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack(alignment: .leading){
            if text.isEmpty{
                placeholder
                    .foregroundColor(purple).opacity(0.7)
                    .padding(.leading)
                    .font(.custom("Avenir", size: 14))
            }
            
            TextField("", text: $text)
                .font(.custom("Avenir", size: 14).bold())
                .foregroundColor(purple)
        }
    }
}
