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
//                    AsyncImage(url: URL(string: "https://your_image_url_address"))
                    let url = URL(string: testResult.pcrImageUrl ?? "")
                    if url != nil{
                        AsyncImage(url:url! ,
                                      placeholder: { Text("Loading ...") },
                                      image: { Image(uiImage: $0).resizable() }).frame(width: UIScreen.main.bounds.size.width - 40, height: 580)
                                                .background(purple.opacity(0.1))
                                                .cornerRadius(10)
                    }
                   
//                    Image("")
//                        .data(url: URL(string: "\(testResult.pcrImageUrl ?? "")")!).frame(width: UIScreen.main.bounds.size.width - 40, height: 650)
//                        .background(purple.opacity(0.1))
//                        .cornerRadius(10)
                    
//                    HStack {
//                        Text("Test Certificate will appear here...")
//                            .font(.custom("Avenir", size: 16))
//                            .fontWeight(.bold)
//                            .foregroundColor(purple)
//                    }.frame(width: UIScreen.main.bounds.size.width - 40, height: 650)
//                        .background(purple.opacity(0.1))
//                        .cornerRadius(10)
                    
                    Spacer()
                    
                }
                
                // MARK: download the saved test certificate
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
        }
    }
}

// MARK: "Share" app function
func shareSheet() {
    guard let data = URL(string: "https://apps.apple.com/us/app/covitrace/id1553975926") else { return }
    let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
}
