//
//  ShowTestCertView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 22/10/2021.
//

import SwiftUI

struct ShowTestCertView: View {
    var body: some View {
        ZStack {
            Background()
            
            VStack(alignment: .center){
                
                Spacer() // <-- just here to center the text
                
                Text("Show Test Certificate Here.....")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                // MARK: download the saved test certificate
                Button(action: {
                    
                    // add download code here
                    
                }, label: {
                    Text("Download")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.white))
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .center)
                    .padding(5)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
            }
        }
    }
}

struct ShowTestCertView_Previews: PreviewProvider {
    static var previews: some View {
        ShowTestCertView()
    }
}
