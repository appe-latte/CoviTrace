//
//  TopView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/02/2021.
//

import SwiftUI

struct TopView: View {
    var body: some View {
        ZStack(alignment: .leading){
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                .frame(height: 200)
            
            VStack(alignment: .center){
               
            // MARK: "Login" Button
            Button(action: {
               
            }, label: {
                Text("CHECK IN")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center)
            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
            .cornerRadius(15)
            
                Text("Check-in data is only stored for a maximum of 14 days and is automatically deleted from our servers.")
                .foregroundColor(.white)
//                .lineLimit(nil)
                .font(.footnote)
                .padding(5)
                
            }
            
          
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
