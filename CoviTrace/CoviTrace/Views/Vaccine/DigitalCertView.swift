//
//  DigitalCertView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/03/2021.
//

import SwiftUI
import Combine
import Firebase
import FirebaseFirestore

struct DigitalCertView: View {
    
    var body: some View {
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            VStack(alignment: .center){
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: Digital Certificate
                    HStack {
                        Text("Digital Certificate will appear here...")
                            .font(.custom("Avenir", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(purple)
                    }.frame(width: UIScreen.main.bounds.size.width - 40, height: 500)
                        .background(purple.opacity(0.1))
                        .cornerRadius(10)
                    
                    Spacer()
                    
                }
                
                // MARK: download the saved digital certificate
                HStack {
                    Spacer()
                    VStack(spacing: 5) {
                        HStack {
                            Button(action: {
                                shareSheet()
                            }, label: {
                                VStack {
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color(.white))
                                    Text("Share")
                                        .font(.custom("Avenir", size: 10))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                }
                            })
                        }.frame(width: 80, height: 80)
                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .clipShape(Circle())
                            .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
}
