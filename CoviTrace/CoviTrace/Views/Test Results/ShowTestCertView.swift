//
//  ShowTestCertView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 22/10/2021.
//

import SwiftUI
import Combine
import Firebase
import Kingfisher
import FirebaseStorage
import FirebaseFirestore

struct ShowTestCertView: View {
    var testResult: TestResults
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center){
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: Image frame
                    let url = URL(string: testResult.pcrImageUrl ?? "")
                    if url != nil{
                        KFImage(url)
                            .placeholder({ progress in
                                Text("Loading Test Result ...")
                                    .font(.custom("Avenir", size: 14).bold())
                                    .foregroundColor(purple)
                            })
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 580)
                            .foregroundColor(Color(.white))
                            .cornerRadius(10)
                            .background(purple.opacity(0.1))
                    }
                    
                    Spacer()
                }
            }
        }
    }
}
