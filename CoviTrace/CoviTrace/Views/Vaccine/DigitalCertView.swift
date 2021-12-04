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
    @State private var showDigiCertSheetView = false
    
    var body: some View {
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            VStack(alignment: .center) {
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: Digital Certificate
                    let url = URL(string: authModel.user!.digiCertImageUrl )
                    if url != nil{
                        AsyncImage(url: url!,
                                   placeholder: {
                            Text("Loading ...")
                                .font(.custom("Avenir", size: 16).bold())
                                .foregroundColor(purple)
                        },
                                   image: { Image(uiImage: $0).resizable() })
                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 600)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                
                // MARK: Upload Digital Certificate
                HStack {
                    Spacer()
                    VStack(spacing: 5) {
                        HStack {
                            Button(action: {
                                self.showDigiCertSheetView.toggle()
                            }, label: {
                                VStack(spacing: 2) {
                                    Text("+ Digital")
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
                            .sheet(isPresented: $showDigiCertSheetView) {
                                DigitalCertUploadView()
                            }
                    }
                }
            }
        }.navigationBarTitle("Digital Certificate")
            .navigationBarTitleDisplayMode(.inline)
    }
}
