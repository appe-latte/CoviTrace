//
//  ShowTestCertView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 22/10/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ShowTestCertView: View {
    @State private var imageUrl = URL(string: "")
    @EnvironmentObject private var viewModel : ResultsViewModel
    
    
    var body: some View {
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            VStack(alignment: .center){
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: Image frame
                    
                    HStack {
//                        Text("Test Certificate will appear here...")
                        Text("\(imageUrl?.absoluteString ?? "Test Certificate will appear here...")")
                            .font(.custom("Avenir", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(purple)
                    }.frame(width: UIScreen.main.bounds.size.width - 40, height: 650)
                        .background(purple.opacity(0.1))
                        .cornerRadius(10)
                        .onAppear(perform: loadImage)
                    
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
    
    func loadImage() {
        let filename = UUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/pcr_certificates/\(filename)")
        
        storageRef.downloadURL { (url, error) in
            if error != nil {
                print("Error: \(error?.localizedDescription)")
                return
            }
            self.imageUrl = url!
        }
    }
}

// MARK: "Share" app function
func shareSheet() {
    guard let data = URL(string: "https://www.covitrace.co.za") else { return } // <-- change url to match that of the document for sharing purposes.
    let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
}
