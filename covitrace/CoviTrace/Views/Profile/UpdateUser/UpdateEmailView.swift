//
//  UpdateEmailView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/12/2021.
//

import SwiftUI
import Firebase
import AlertToast
import FirebaseFirestore

struct UpdateEmailView: View {
    @State private var isPresented = true
    @State var email  = ""
    
    // MARK: Alert
    @State private var showToastAlert : Bool = false
    @State private var errTitle = ""
    @State private var errMessage = ""
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var authModel = AuthViewModel()
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Text("Update Email Address")
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
                SimpleTextField(text: $email, placeholder: Text("Enter email address"))
                    .foregroundColor(purple)
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                
                // MARK: "Log Results" Button
                Button(action: {
                    submit_email()
                    showToastAlert = true
                    email.removeAll()
                    self.hideKeyboard()
                }, label: {
                    HStack {
                        Text("Submit")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                }).frame(width: 150, height: 50)
                    .background(purple)
                    .cornerRadius(10)
                    .padding(.top, 2)
                    .disabled((email != "") ? false : true)
                    .opacity((email != "") ? 1 : 0.6)
                
                Spacer()
            }.padding(.top, 15)
                .toast(isPresenting: $showToastAlert){
                    AlertToast(displayMode: .alert, type: .complete(green), title: Optional(errTitle), subTitle: Optional(errMessage))
                }
        }.background(bgWhite())
            .accentColor(purple)
    }
    
    func submit_email(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["email": email], merge: true)
        
        self.errTitle = "Success!"
        self.errMessage = "Email has successfully been updated"
        self.showToastAlert = true
    }
}
