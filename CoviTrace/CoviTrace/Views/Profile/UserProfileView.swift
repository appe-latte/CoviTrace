//
//  UserProfileView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/12/2021.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct UserProfileView: View {
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
    
    @ObservedObject var authModel = AuthViewModel()
    
    @Environment(\.editMode) private var editMode
    @State private var disableTextField = true
    @State private var disableIdTextField = true
    @State private var disableEmailTextField = true
    
    var body: some View {
        let fullName = authModel.user!.firstName + " " + authModel.user!.lastName
        let cellNum = authModel.user!.cellNum
        let dob = authModel.user!.dob
        let email = authModel.user!.email
        let idNum = authModel.user!.idNumber
        let idType = authModel.user!.idType
        let regCountry = authModel.user!.regCountry
        let profVerified = authModel.user!.verified
        
        ZStack {
            VStack {
                Form {
                    
                    // MARK: User Information section
                    Section {
                        // MARK: Profile Image
                        VStack {
                            HStack {
                                Text("Update Profile Image")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                
                                Spacer()
                                
                                Button(action: {
                                    self.showProfileImageUpdateSheetView.toggle()
                                }, label: {
                                    Text("UPDATE")
                                        .font(.custom("Avenir", size: 13))
                                        .foregroundColor(green)
                                }).buttonStyle(PlainButtonStyle())
                                    .padding(5)
                            }
                        }.sheet(isPresented: $showProfileImageUpdateSheetView) {
                            UpdateProfileImageView()
                        }
                        
                        // MARK: Name
                        VStack {
                            HStack {
                                Text("Name:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                            }
                            TextField("\(fullName)", text: $fullName)
                                .disabled(disableTextField)
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
                                    Text("UPDATE")
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
                                    Text("UPDATE")
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
                                    .accentColor(.red)
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
                                    Text("UPDATE")
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
                                    .accentColor(.red)
                            }
                        }.onSubmit {
                            submit_email()
                        }
                        
                        // MARK: Cell No.
                        VStack {
                            HStack {
                                Text("Cell Number:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                            }
                            TextField("\(cellNum)", text: $cellNum)
                                .disabled(disableTextField)
                                .foregroundColor(purple)
                        }
                        
                        Text("To update your account name and cell phone number contact: admin@covitrace.co.za")
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .font(.custom("Avenir", size: 12).bold())
                            .accentColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                    
                    // MARK: Verification Section
                    Section(header: Text("Verification")) {
                        // MARK: Reg Country
                        HStack {
                            Text("Reg. Country:")
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            Spacer()
                            Text(regCountry)
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        }
                        
                        // MARK: Profile Verification
                        HStack {
                            Text("Verification:")
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            Spacer()
                            Text(profVerified)
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        }
                        
                        // MARK: Verification Document
                        HStack {
                            Text("Verification Document:")
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            Spacer()
                            Text(idType)
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        }
                        
                        Text("To have your profile verified please email a copy of your Govt issued identity document to: verify@covitrace.co.za").lineLimit(nil)
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .font(.custom("Avenir", size: 12).bold())
                            .accentColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                    
                    // MARK: Verification View
                    //                    HStack {
                    //                        Button(action: {
                    //                            self.verifyIdSheetView.toggle()
                    //                        }, label: {
                    //                            HStack {
                    //                                Text("Profile Verification")
                    //                                    .font(.custom("Avenir", size: 15))
                    //                                    .fontWeight(.bold)
                    //                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    //
                    //                                Spacer()
                    //
                    //                                Image("arrow-right")
                    //                                    .resizable()
                    //                                    .frame(width: 25, height: 25)
                    //                                    .padding(2)
                    //                            }
                    //                        })
                    //                    }.sheet(isPresented: $verifyIdSheetView) {
                    //                        VerificationDocView()
                    //                    }
                }
            }
            
            Spacer()
        }
        .navigationTitle("User Information")
        .navigationBarTitleDisplayMode(.inline)
    }
    
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
