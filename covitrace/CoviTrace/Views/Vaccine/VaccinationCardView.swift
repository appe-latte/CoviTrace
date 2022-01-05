//
//  VaccinationCardView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/12/2021.
//

import SwiftUI
import Combine
import Firebase
import FirebaseFirestore

struct VaccinationCardView: View {
    @EnvironmentObject private var authModel : AuthViewModel
    @State private var showDigiCertSheetView = false
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center) {
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: Digital Certificate
                    let url = URL(string: authModel.user!.vaccCardImageUrl )
                    if url != nil{
                        AsyncImage(url: url!,
                                   placeholder: {
                            Text("Loading Vaccination Card ...")
                                .font(.custom("Avenir", size: 14).bold())
                                .foregroundColor(purple)
                        },
                                   image: { Image(uiImage: $0).resizable() })
                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 600)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
            }
        }.navigationBarTitle("Vaccination Card")
            .navigationBarTitleDisplayMode(.inline)
    }
}
