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
    @State var expandImg : Bool = false
    @State var zoomScale : CGFloat = 1.0
 
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
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 580)
                            .foregroundColor(Color(.white))
                            .cornerRadius(10)
                            .scaleEffect(zoomScale)
                            .background(purple.opacity(0.1))
                            .gesture(MagnificationGesture()
                                        .onChanged { value in
                                            self.zoomScale = value.magnitude
                                        })
                    }
                    
                    Spacer()
                }
            }
        }
    }
}
