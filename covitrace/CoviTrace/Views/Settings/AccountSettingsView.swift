//
//  PrivacySettingsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/11/2021.
//

import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore

struct AccountSettingsView: View {
    @State private var previousCellNum = ""
    @State private var newCellNum = ""
    @State private var otpCode = ""
    
    // MARK: Objects
    @EnvironmentObject private var appLockModel : AppLockViewModel
    @EnvironmentObject var authModel : AuthViewModel
    
    var isAppLockEnabled = false
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                    
                    // MARK: Previous cellphone number
                    HStack {
                        Section(header: Text("New cell no.")) {
                            SimpleTextField(text: $newCellNum, placeholder: Text("enter cellphone no."))
                                .font(.custom("Avenir", size: 12).bold())
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            
                            Button(action: {
                                
                                // <---- code for submitting new number
                                
                            }, label: {
                                Image("check")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(1)
                            }).frame(width: 30, height: 30)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .cornerRadius(10)
                                .padding(.top, 2)
                        }
                    }
                    
                    // MARK: Delete Account
                    Section(header: Text("Permanently Delete Account")) {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                self.deleteUser()
                            }, label: {
                                HStack {
                                    Image("trash")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(1)
                                    Text("DELETE ACCOUNT")
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(.red)
                                }
                            }).frame(width: 200, height: 30)
                            
                            Spacer()
                        }
                    }
                }
            }.background(bgPurple())}
        .navigationBarTitle("Account Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Delete User functiona
    func deleteUser() {
        let userId = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("users").document(userId).delete() { err in
            if let err = err  {
                print("Error: \(err)")
            } else {
                Auth.auth().currentUser!.delete { error in
                    if let error = error {
                        print("Error deleting the user: \(error)")
                    } else {
                        print("Account has been deleted")
                    }
                }
            }
        }
    }
}
