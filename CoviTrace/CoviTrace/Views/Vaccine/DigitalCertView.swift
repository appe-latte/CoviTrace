//
//  DigitalCertView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/03/2021.
//

import SwiftUI
import Combine
import Firebase
import Kingfisher
import FirebaseFirestore

struct DigitalCertView: View {
    @EnvironmentObject private var authModel : AuthViewModel
    @State private var showDigiCertSheetView = false
    @State var expandImg : Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: Digital Certificate
                    let url = URL(string: authModel.user!.digiCertImageUrl )
                    if url != nil{
                        KFImage(url)
                            .placeholder({ progress in
                                Text("Loading Digital Certificate ...")
                                    .font(.custom("Avenir", size: 14).bold())
                                    .foregroundColor(purple)
                            })
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 600)
                            .foregroundColor(Color(.white))
                            .cornerRadius(10)
                            .gesture(
                                TapGesture(count: 1)
                                    .onEnded {
                                        self.expandImg = true
                                    }).sheet(isPresented: $expandImg){
                                        KFImage(url)
                                            .frame(width: UIScreen.main.bounds.size.width - 40, height: UIScreen.main.bounds.size.height - 10)
                                    }
                    }
                    Spacer()
                }
            }
        }
        .navigationBarTitle("Digital Certificate")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: {
                self.showDigiCertSheetView.toggle()
            }, label: {
                Text("+ Add")
                    .font(.system(size: 13))
                    .foregroundColor(Color.white)
            }).sheet(isPresented: $showDigiCertSheetView) {
                DigitalCertUploadView()
            }
        }
    }
}
