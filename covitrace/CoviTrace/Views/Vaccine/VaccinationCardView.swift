//
//  VaccinationCardView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/12/2021.
//

import SwiftUI
import Combine
import Firebase
import Kingfisher
import FirebaseFirestore

struct VaccinationCardView: View {
    @EnvironmentObject private var authModel : AuthViewModel
    @State private var showVaccCardSheetView = false
    @State var expandImg : Bool = false
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center) {
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: Vaccincation Card
                    let url = URL(string: authModel.user!.vaccCardImageUrl)
                    if url != nil{
                        KFImage(url)
                            .placeholder({ progress in
                                Text("Loading Vaccination Card ...")
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
                                            .resizable()
                                            .scaledToFit()
                                        Text("Swipe down to close")
                                            .font(.custom("Avenir", size: 12).bold())
                                            .foregroundColor(purple)
                                    }
                    }
                    Spacer()
                }
            }
        }
        .navigationBarTitle("Vaccination Card")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: {
                self.showVaccCardSheetView.toggle()
            }, label: {
                Text("+ Add")
                    .font(.system(size: 13))
                    .foregroundColor(Color.white)
            }).sheet(isPresented: $showVaccCardSheetView) {
                VaccCardUploadView()
            }
        }
    }
}
