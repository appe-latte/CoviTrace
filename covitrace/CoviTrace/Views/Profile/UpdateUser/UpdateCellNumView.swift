//
//  UpdateCellNumView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/12/2021.
//

import SwiftUI
import Firebase
import AlertToast
import FirebaseFirestore

struct UpdateCellNumView: View {
    @State private var isPresented = true
    @State var cellNum  = ""
    
    // MARK: Alert
    @State private var showToastAlert : Bool = false
    @State private var errTitle = ""
    @State private var errMessage = ""
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var authModel = AuthViewModel()
    
    var body: some View {
        let green = Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)
        
        ZStack {
            VStack {
                HStack {
                    Text("Update Cell No.")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("close")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }).padding(5)
                        .clipShape(Circle())
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                
                // MARK: Test Reference Number TextField
                SimpleTextField(text: $cellNum, placeholder: Text("Enter cellphone number"))
                    .foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: "Log Results" Button
                Button(action: {
                    submit_cellNum()
                    showToastAlert = true
                    cellNum.removeAll()
                    self.hideKeyboard()
                }, label: {
                    HStack {
                        Text("Submit")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                }).frame(width: 150, height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.top, 2)
                
                Spacer()
            }.padding(.top, 15)
                .toast(isPresenting: $showToastAlert){
                    AlertToast(displayMode: .alert, type: .complete(green), title: Optional(errTitle), subTitle: Optional(errMessage))
                }
        }.background(bgGrad())
            .navigationBarHidden(false)
            .accentColor(Color.white)
    }
    
    func submit_cellNum(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["cell_num": cellNum], merge: true)
        
        self.errTitle = "Success!"
        self.errMessage = "Cellphone number has successfully been updated"
        self.showToastAlert = true
    }
}