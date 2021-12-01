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
        ZStack(alignment: .leading){
            if text.isEmpty{
                placeholder
                    .foregroundColor(Color(.white))
                    .padding(.leading)
                    .font(.custom("Avenir", size: 14).bold())
            }
            
            TextField("", text: $text)
                .font(.custom("Avenir", size: 14).bold())
        }.foregroundColor(.white)
    }
}
