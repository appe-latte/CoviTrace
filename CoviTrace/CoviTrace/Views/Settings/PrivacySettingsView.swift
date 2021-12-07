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

struct PrivacySettingsView: View {
    @State private var previousCellNum = ""
    @State private var newCellNum = ""
    @State private var otpCode = ""
    
    // MARK: Objects
    @EnvironmentObject private var appLockModel : AppLockViewModel
    @EnvironmentObject var authModel : AuthViewModel
    
    var isAppLockEnabled = false
    
    var body: some View {
        ZStack {
            bgPurple()
            
            VStack {
                Form {
                    Section {
                        HStack {
                            Image(systemName: "faceid")
                                .font(.system(size: 26))
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .padding(.trailing, 5)
                            
                            Toggle("Secure with Face ID / Touch ID", isOn: $appLockModel.isAppLockEnabled)
                                .font(.custom("Avenir", size: 14).bold())
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        }.toggleStyle(SwitchToggleStyle(tint: Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)))
                            .onChange(of: appLockModel.isAppLockEnabled, perform: { value in
                                appLockModel.appLockStateChange(appLockState: value)
                            })
                        
                        Text("When Face ID is enabled, you'll require it every time you wish to unlock the Covitrace.")
                            .font(.custom("Avenir", size: 12).bold())
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                    }
                    
                    // MARK: Previous cellphone number
                    Section(header: Text("Change Cell Number")) {
                        SimpleTextField(text: $previousCellNum, placeholder: Text("Previous cellphone number"))
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        
                        // MARK: New cellphone number
                        SimpleTextField(text: $newCellNum, placeholder: Text("New cellphone number"))
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                // <---- code for submitting new number
                            }, label: {
                                Text("Submit")
                                    .font(.custom("Avenir", size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }).frame(width: 150, height: 30)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .cornerRadius(10)
                                .padding(.top, 2)
                            
                            Spacer()
                        }
                    }
                    
                    // MARK: OTP confirmation
                    Section {
                        SimpleTextField(text: $otpCode, placeholder: Text("Enter OTP code"))
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                // <---- code for OTP goes here
                            }, label: {
                                Text("Confirm")
                                    .font(.custom("Avenir", size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }).frame(width: 150, height: 30)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .cornerRadius(10)
                                .padding(.top, 2)
                            
                            Spacer()
                        }
                    }
                    
                    // MARK: Delete Account
                    Section(header: Text("Permanently Delete Account")) {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                self.deleteUser()
                            }, label: {
                                Text("Delete Account")
                                    .font(.custom("Avenir", size: 16))
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                            }).frame(width: 150, height: 30)
                            
                            Spacer()
                        }
                    }
                }
            }
        }.navigationBarTitle("Account Settings")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Delete User function
    
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
