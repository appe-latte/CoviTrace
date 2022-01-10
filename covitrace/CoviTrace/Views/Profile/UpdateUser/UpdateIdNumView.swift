//
//  UpdateIdNumView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/12/2021.
//

import SwiftUI
import Firebase
import AlertToast
import FirebaseFirestore

struct UpdateIdNumView: View {
    @State private var isPresented = true
    @State var idNumber = ""
    
    // MARK: Alert
    @State private var showToastAlert : Bool = false
    @State private var errTitle = ""
    @State private var errMessage = ""
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var authModel = AuthViewModel()
    
    var body: some View {
        let idNum = authModel.user?.idNumber ?? ""
        
        ZStack {
            VStack {
                HStack {
                    Text("Update ID Number")
                        .foregroundColor(purple)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("close-p")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }).padding(5)
                        .clipShape(Circle())
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                
                // MARK: Test Reference Number TextField
                SimpleTextField(text: $idNumber, placeholder: Text("\(idNum)"))
                    .foregroundColor(purple)
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                
                // MARK: "Log Results" Button
                Button(action: {
                    submit_idNum()
                    showToastAlert = true
                    idNumber.removeAll()
                    self.hideKeyboard()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Text("Submit")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }).buttonStyle(purpleButton())
                    .padding(.top, 2)
                    .disabled((idNumber != "") ? false : true)
                    .opacity((idNumber != "") ? 1 : 0.6)
                
                Spacer()
            }.padding(.top, 15)
                .toast(isPresenting: $showToastAlert){
                    AlertToast(displayMode: .alert, type: .complete(green), title: Optional(errTitle), subTitle: Optional(errMessage))
                }
        }.background(bgWhite())
            .accentColor(purple)
    }
    
    func submit_idNum(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["id_num": idNumber], merge: true)
        
        self.errTitle = "Success!"
        self.errMessage = "ID number has successfully been updated"
        self.showToastAlert = true
    }
}
