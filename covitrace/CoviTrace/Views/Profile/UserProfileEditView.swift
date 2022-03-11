//
//  UserProfileEditView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 25/02/2022.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct UserProfileEditView: View {
    @State var cellNum = ""
    @State var idNumber = ""
    @State var email  = ""
    @State var dob = ""
    @State var fullName = ""
    
    // MARK: Sheets
    @State private var verifyIdSheetView = false
    @State private var showDobUpdateSheetView = false
    @State private var showEmailUpdateSheetView = false
    @State private var showIdUpdateSheetView = false
    @State private var showProfileImageUpdateSheetView = false
    
    @EnvironmentObject var authModel : AuthViewModel
    
    @Environment(\.editMode) private var editMode
    @State var disableTextField = true
    @State var disableIdTextField = true
    @State var disableEmailTextField = true
    @State var rowHeight = 50.0
    
    var body: some View {
        let dob = authModel.user!.dob
        let email = authModel.user!.email
        let idNum = authModel.user!.idNumber
        
        ZStack {
            VStack {
                Form {
                    
                    // MARK: User Information section
                    Section {
                        // MARK: Profile Image
                        VStack {
                            HStack {
                                Button(action: {
                                    self.showProfileImageUpdateSheetView.toggle()
                                }, label: {
                                    Text("UPDATE PROFILE IMAGE")
                                        .font(.custom("Avenir", size: 13))
                                        .foregroundColor(green)
                                }).buttonStyle(PlainButtonStyle())
                                    .padding(5)
                                
                                Spacer()
                            }
                        }.sheet(isPresented: $showProfileImageUpdateSheetView) {
                            UpdateProfileImageView()
                        }
                        
                        // MARK: DoB
                        VStack {
                            HStack {
                                Text("Date of Birth:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Button(action: {
                                    self.showDobUpdateSheetView.toggle()
                                }, label: {
                                    Text("EDIT")
                                        .font(.custom("Avenir", size: 13))
                                        .foregroundColor(green)
                                }).buttonStyle(PlainButtonStyle())
                            }
                            TextField("\(dob)", text: $dob)
                                .disabled(disableTextField)
                        }.sheet(isPresented: $showDobUpdateSheetView) {
                            UpdateDobView()
                        }
                        
                        // MARK: ID No.
                        VStack {
                            HStack {
                                Text("ID Number:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Button(action: {
                                    self.disableIdTextField.toggle()
                                }, label: {
                                    Text("EDIT")
                                        .font(.custom("Avenir", size: 13))
                                        .foregroundColor(green)
                                }).buttonStyle(PlainButtonStyle())
                            }
                            // Change edit state
                            if disableIdTextField == true {
                                TextField("\(idNum)", text: $idNumber)
                                    .disabled(disableTextField)
                                    .foregroundColor(Color(UIColor.lightGray))
                            } else {
                                TextField("", text: $idNumber)
                                    .foregroundColor(purple)
                                    .accentColor(purple)
                            }
                        }.onSubmit {
                            submit_idNum()
                        }
                        
                        // MARK: Email
                        VStack {
                            HStack {
                                Text("Email:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Button(action: {
                                    self.disableEmailTextField.toggle()
                                }, label: {
                                    Text("EDIT")
                                        .font(.custom("Avenir", size: 13))
                                        .foregroundColor(green)
                                }).buttonStyle(PlainButtonStyle())
                            }
                            // Change edit state
                            if disableEmailTextField == true {
                                TextField("\(email)", text: $email)
                                    .disabled(disableTextField)
                                    .foregroundColor(Color(UIColor.lightGray))
                            } else {
                                TextField("", text: $email)
                                    .foregroundColor(purple)
                                    .accentColor(purple)
                            }
                        }.onSubmit {
                            submit_email()
                        }
                        
                        Text("To update your account name and cell phone number contact: admin@covitrace.co.za")
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .font(.custom("Avenir", size: 12).bold())
                            .accentColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                }
                .environment(\.defaultMinListRowHeight, rowHeight)
            }
            
            Spacer()
        }
        .navigationTitle("User Information")
        .navigationBarTitleDisplayMode(.inline)
    }
// MARK: Functions for submitting data to Firebase
    func submit_email(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["email": email], merge: true)
        self.disableEmailTextField.toggle()
    }
    
    func submit_idNum(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["id_num": idNumber], merge: true)
        self.disableIdTextField.toggle()
    }
}

