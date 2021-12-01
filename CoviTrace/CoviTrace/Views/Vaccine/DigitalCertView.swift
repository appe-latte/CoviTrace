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
    @EnvironmentObject private var authModel : AuthViewModel
    
    var body: some View {
//        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            VStack(alignment: .center) {
                
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: Digital Certificate
                    //                    HStack {
                    //                        Text("Digital Certificate will appear here...")
                    //                            .font(.custom("Avenir", size: 16))
                    //                            .fontWeight(.bold)
                    //                            .foregroundColor(purple)
                    //                    }.frame(width: UIScreen.main.bounds.size.width - 40, height: 500)
                    //                        .background(purple.opacity(0.1))
                    //                        .cornerRadius(10)
                    
                    Image(systemName: "")
                        .data(url: URL(string: "\(authModel.user!.digiCertImageUrl)")!) // <- error: occassionally crashes displaying "Unexpectedly found nil while unwrapping an Optional value". Happens mostly at app launch after registration or occassionally when the user is opening the app after a while.
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.size.width - 40, height: 650)
                        .cornerRadius(10)
                    
                    Spacer()
                    
                }
                
                // MARK: Share saved digital certificate
                HStack {
                    Spacer()
                    VStack(spacing: 5) {
                        HStack {
                            Button(action: {
                                shareSheet()
                            }, label: {
                                VStack(spacing: 2) {
                                    Text("Download")
                                        .font(.custom("Avenir", size: 10))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                    Text("Certificate")
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
        }.navigationBarTitle("Digital Certificate")
            .navigationBarTitleDisplayMode(.inline)
    }
}
