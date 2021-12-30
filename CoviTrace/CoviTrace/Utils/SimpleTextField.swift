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
//    static let bgPurple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
    
    var body: some View {
       let bgPurple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack(alignment: .leading){
            if text.isEmpty{
                placeholder
                    .padding(.leading)
                    .font(.custom("Avenir", size: 14))
            }
            
            TextField("", text: $text)
                .font(.custom("Avenir", size: 14).bold())
                .foregroundColor(bgPurple)
        }.underlineTextField()
    }
}

extension View {
func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
            .padding(10)
    }
}
