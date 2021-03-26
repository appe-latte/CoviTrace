//
//  SimpleTextField.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 13/02/2021.
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
                    .font(.footnote)
            }
            
            TextField("", text: $text)
        }.foregroundColor(.white)
    }
}