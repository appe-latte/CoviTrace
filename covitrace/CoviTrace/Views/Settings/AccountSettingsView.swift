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
    @State var showUpdateCellNumSheetView = false
    @State var showUpdateIdNumSheetView = false
    @State var showUpdateDobSheetView = false
    
    @State var accountDeletionModal_shown = false
    
    // MARK: Objects
    @EnvironmentObject private var appLockModel : AppLockViewModel
    @EnvironmentObject var authModel : AuthViewModel
    
    var isAppLockEnabled = false
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                    Section(header: Text("Update User Information")) {
                        
                        // MARK: Update ID Number
                        Button(action: {
                            self.showUpdateIdNumSheetView.toggle()
                        }, label: {
                            HStack {
                                Image("edit-button")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(1)
                                Text("Update ID number")
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
                                Text("Update date of birth")
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
                                Text("Update cellphone number")
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
                                Text("Update profile image")
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
                            Button(action: {
                                self.accountDeletionModal_shown.toggle()
                            }, label: {
                                HStack {
                                    Image("trash")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(1)
                                    Text("Delete My Account")
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
                            })
                        }
                    }
                }
            }.background(bgPurple())
            
            AccountDeletionModalView(isShown: $accountDeletionModal_shown, modalHeight: 400) {
                AccountDeletionView()
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
