//
//  PrivacySettingsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/11/2021.
//

import SwiftUI
import Combine
import FirebaseAuth
import AlertToast
import FirebaseFirestore

struct AccountSettingsView: View {
    @State var cellNum = ""
    @State var idNumber = ""
    @State var email  = ""
    @State var dob = ""
    
    // MARK: Alert
    @State private var showToastAlert : Bool = false
    @State private var errTitle = ""
    @State private var errMessage = ""
    
    // MARK: Objects
    @EnvironmentObject private var appLockModel : AppLockViewModel
    @EnvironmentObject var authModel : AuthViewModel
    
    var isAppLockEnabled = false
    
    var body: some View {
        let green = Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)
        
        ZStack {
            VStack {
                Form {
                    Section(header: Text("Update User Information")){
                        // MARK: New cellphone number
                        HStack {
                            SimpleTextField(text: $cellNum, placeholder: Text("enter cellphone number"))
                                .font(.custom("Avenir", size: 12).bold())
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            
                            Button(action: {
                                submit_cellNum()
                                showToastAlert = true
                                cellNum.removeAll()
                                self.hideKeyboard()
                            }, label: {
                                Image("check")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(1)
                            }).frame(width: 30, height: 30)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .cornerRadius(10)
                                .padding(.top, 2)
                                .disabled((cellNum != "") ? false : true)
                                .opacity((cellNum != "") ? 1 : 0.6)
                        }.padding(.horizontal, 2)
                        
                        // MARK: Update ID Number
                        HStack {
                            SimpleTextField(text: $idNumber, placeholder: Text("enter id number"))
                                .font(.custom("Avenir", size: 12).bold())
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            
                            Button(action: {
                                submit_idNum()
                                showToastAlert = true
                                idNumber.removeAll()
                                self.hideKeyboard()
                            }, label: {
                                Image("check")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(1)
                            }).frame(width: 30, height: 30)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .cornerRadius(10)
                                .padding(.top, 2)
                                .disabled((idNumber != "") ? false : true)
                                .opacity((idNumber != "") ? 1 : 0.6)
                        }.padding(.horizontal, 2)
                        
                        // MARK: Update DoB
                        HStack {
                            SimpleTextField(text: $dob, placeholder: Text("dd/mm/yyyy"))
                                .font(.custom("Avenir", size: 12).bold())
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            
                            Button(action: {
                                submit_dob()
                                showToastAlert = true
                                dob.removeAll()
                                self.hideKeyboard()
                            }, label: {
                                Image("check")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(1)
                            }).frame(width: 30, height: 30)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .cornerRadius(10)
                                .padding(.top, 2)
                                .disabled((dob != "") ? false : true)
                                .opacity((dob != "") ? 1 : 0.6)
                        }.padding(.horizontal, 2)
                        
                        // MARK: Update Email Address
                        HStack {
                            SimpleTextField(text: $email, placeholder: Text("enter email"))
                                .font(.custom("Avenir", size: 12).bold())
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            
                            Button(action: {
                                submit_email()
                                showToastAlert = true
                                email.removeAll()
                                self.hideKeyboard()
                            }, label: {
                                Image("check")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(1)
                            }).frame(width: 30, height: 30)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .cornerRadius(10)
                                .padding(.top, 2)
                                .disabled((email != "") ? false : true)
                                .opacity((email != "") ? 1 : 0.6)
                        }.padding(.horizontal, 2)
                    }
                    
                    // MARK: Delete Account
                    Section(header: Text("Permanently Delete Account")) {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                
                                self.deleteUser()
                                showToastAlert = true
                                //                                authModel.signOut()
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
        .toast(isPresenting: $showToastAlert){
            AlertToast(displayMode: .alert, type: .complete(green), title: Optional(errTitle), subTitle: Optional(errMessage))
        }
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
                        self.errTitle = "Error!"
                        self.errMessage = "Error deleting the user: \(error)"
                        self.showToastAlert = true
                    } else {
                        self.errTitle = "Account Deleted"
                        self.errMessage = "Your user account has successfully been deleted"
                        self.showToastAlert = true
                        authModel.signOut()
                    }
                }
            }
        }
    }
    
    // MARK: Upload to "Vaccinations" DB
    func submit_email(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["email": email], merge: true)
        
        self.errTitle = "Success!"
        self.errMessage = "Email has successfully been updated"
        self.showToastAlert = true
    }
    
    func submit_dob(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["dob": dob], merge: true)
        
        self.errTitle = "Success!"
        self.errMessage = "DOB has successfully been updated"
        self.showToastAlert = true
    }
    
    func submit_idNum(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["id_num": idNumber], merge: true)
        
        self.errTitle = "Success!"
        self.errMessage = "ID number has successfully been updated"
        self.showToastAlert = true
    }
    
    func submit_cellNum(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["cell_num": cellNum], merge: true)
        
        self.errTitle = "Success!"
        self.errMessage = "Cellphone number has successfully been updated"
        self.showToastAlert = true
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
