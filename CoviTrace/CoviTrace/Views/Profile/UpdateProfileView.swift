//
//  UpdateProfileView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 30/11/2021.
//

import SwiftUI
import Combine
import Firebase

struct UpdateProfileView: View {
    @State private var idNumber = ""
    @State private var email  = ""
    @State private var dob = ""
    
    @State private var keyboardHeight: CGFloat = 0
    
    @ObservedObject private var authModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack {
                    Text("Update information")
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
                
                Spacer()
                    .frame(height: 15)
                
                // MARK: ID Number
                HStack(spacing: 10) {
                    CustomTextField(text: $idNumber, placeholder: Text("ID Number"), imageName: "note.text")
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(width: 300, height: 50)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    Button(action: {
                        submit_idNum()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .font(.custom("Avenir", size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    })
                        .frame(width: 50, height: 50)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                        .padding(.top, 2)
                }
                
                // MARK: DOB
                HStack(spacing: 10) {
                    CustomTextField(text: $dob, placeholder: Text("DD / MM / YYYY"), imageName: "calendar")
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(width: 300, height: 50)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    Button(action: {
                        submit_dob()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .font(.custom("Avenir", size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    })
                        .frame(width: 50, height: 50)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                        .padding(.top, 2)
                }
                
                // MARK: Email
                HStack(spacing: 10) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(width: 300, height: 50)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    Button(action: {
                        submit_email()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .font(.custom("Avenir", size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    })
                        .frame(width: 50, height: 50)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                        .padding(.top, 2)
                }
                
                Spacer()
            }
        }.background(bgPurple())
    }
    
    // MARK: Upload to "Vaccinations" DB
    func submit_email(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["email": email], merge: true)
    }
    
    func submit_dob(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["dob": dob], merge: true)
    }
    
    func submit_idNum(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["id_num": idNumber], merge: true)
    }
}
