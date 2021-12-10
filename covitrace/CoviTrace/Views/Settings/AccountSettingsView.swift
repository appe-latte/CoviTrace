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
    @State var dob = ""
    @State var showProfileImgSheetView = false
    @State var showUpdateEmailSheetView = false
    @State var showUpdateCellNumSheetView = false
    @State var showUpdateIdNumSheetView = false
    @State var showUpdateDobSheetView = false
    
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
                    Section(header: Text("Update User Information")) {
                        // MARK: Update Email
                        Button(action: {
                            self.showUpdateEmailSheetView.toggle()
                        }, label: {
                            HStack {
                                Image("edit-button")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(1)
                                Text("Change email address")
                                    .font(.custom("Avenir", size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .font(Font.title.weight(.semibold))
                                    .foregroundColor(Color(.gray)).opacity(0.5)
                                    .frame(width: 13, height: 13)
                            }
                        }).foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .sheet(isPresented: $showUpdateEmailSheetView) {
                                UpdateEmailView()
                            }
                        
                        // MARK: Update ID Number
                        Button(action: {
                            self.showUpdateIdNumSheetView.toggle()
                        }, label: {
                            HStack {
                                Image("edit-button")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(1)
                                Text("Change ID number")
                                    .font(.custom("Avenir", size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .font(Font.title.weight(.semibold))
                                    .foregroundColor(Color(.gray)).opacity(0.5)
                                    .frame(width: 13, height: 13)
                            }
                        }).foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .sheet(isPresented: $showUpdateIdNumSheetView) {
                                UpdateIdNumView()
                            }
                        
                        // MARK: Update DOB
                        Button(action: {
                            self.showUpdateDobSheetView.toggle()
                        }, label: {
                            HStack {
                                Image("edit-button")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(1)
                                Text("Change DOB")
                                    .font(.custom("Avenir", size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .font(Font.title.weight(.semibold))
                                    .foregroundColor(Color(.gray)).opacity(0.5)
                                    .frame(width: 13, height: 13)
                            }
                        }).foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .sheet(isPresented: $showUpdateDobSheetView) {
                                UpdateDobView()
                            }
                        
                        // MARK: Update Cellphone number
                        Button(action: {
                            self.showUpdateCellNumSheetView.toggle()
                        }, label: {
                            HStack {
                                Image("edit-button")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(1)
                                Text("Change cellphone number")
                                    .font(.custom("Avenir", size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .font(Font.title.weight(.semibold))
                                    .foregroundColor(Color(.gray)).opacity(0.5)
                                    .frame(width: 13, height: 13)
                            }
                        }).foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .sheet(isPresented: $showUpdateCellNumSheetView) {
                                UpdateCellNumView()
                            }
                        
                        // MARK: Update Profile Image
                        Button(action: {
                            self.showProfileImgSheetView.toggle()
                        }, label: {
                            HStack {
                                Image("image")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(1)
                                Text("Change profile image")
                                    .font(.custom("Avenir", size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .font(Font.title.weight(.semibold))
                                    .foregroundColor(Color(.gray)).opacity(0.5)
                                    .frame(width: 13, height: 13)
                            }
                        }).foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .sheet(isPresented: $showProfileImgSheetView) {
                                UpdateProfileImageView()
                            }
                    }
                    
                    // MARK: Delete Account
                    Section(header: Text("Permanently Delete Account")) {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                self.deleteUser()
                                showToastAlert = true
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
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
