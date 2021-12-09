//
//  ShowTestCertView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 22/10/2021.
//

import SwiftUI
import Combine
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct ShowTestCertView: View {
    var testResult: TestResults
    
    var body: some View {
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            VStack(alignment: .center){
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: Image frame
                    let url = URL(string: testResult.pcrImageUrl ?? "")
                    if url != nil{
                        AsyncImage(url:url! ,
                                   placeholder: {
                            Text("Loading Test Result ...")
                                .font(.custom("Avenir", size: 14).bold())
                                .foregroundColor(purple)
                        },
                                   image: { Image(uiImage: $0).resizable() }).frame(width: UIScreen.main.bounds.size.width - 40, height: 580)
                            .background(purple.opacity(0.1))
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                
                // MARK: Download certificate
//                HStack {
//                    Spacer()
//                    VStack(spacing: 5) {
//                        HStack {
//                            Button(action: {
//                                // <---- code missing
//                            }, label: {
//                                VStack(spacing: 2) {
//                                    Text("Download")
//                                        .font(.custom("Avenir", size: 10))
//                                        .fontWeight(.bold)
//                                        .foregroundColor(Color.white)
//                                    Text("Certificate")
//                                        .font(.custom("Avenir", size: 10))
//                                        .fontWeight(.bold)
//                                        .foregroundColor(Color.white)
//                                }
//                            })
//                        }.frame(width: 80, height: 80)
//                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
//                            .clipShape(Circle())
//                            .padding(.horizontal, 20)
//                    }
//                }
            }
        }
    }
}
