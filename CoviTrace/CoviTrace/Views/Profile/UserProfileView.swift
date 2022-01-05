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
    
    @State private var updateProfileSheetView = false
    @State private var verifyIdSheetView = false
    @State private var showVaccCardView = false
    
    @ObservedObject var authModel = AuthViewModel()
    
    @Environment(\.editMode) private var editMode
    @State private var disableTextField = true
    
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
                        // MARK: Name
                        VStack {
                            HStack {
                                Text("Name:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Button(action: {
                                    
                                }, label: {
                                    Text("EDIT")
                                        .font(.custom("Avenir", size: 15))
                                        .foregroundColor(green)
                                }).buttonStyle(PlainButtonStyle())
                            }
                            TextField("\(fullName)", text: $fullName)
                                .disabled(disableTextField)
                                .onChange(of: editMode?.wrappedValue) { newValue in
                                    if (newValue != nil) && (newValue!.isEditing) {
                                        // Edit button tapped
                                        disableTextField = false
                                    }
                                    else {
                                        // Done button tapped
                                        disableTextField = true
                                    }
                                }
                        }
                        
                        // MARK: DoB
                        VStack {
                            HStack {
                                Text("Date of Birth:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Button(action: {
                                    
                                }, label: {
                                    Text("EDIT")
                                        .font(.custom("Avenir", size: 15))
                                        .foregroundColor(green)
                                }).buttonStyle(PlainButtonStyle())
                            }
                            TextField("\(dob)", text: $dob)
                                .disabled(disableTextField)
                                .onChange(of: editMode?.wrappedValue) { newValue in
                                    if (newValue != nil) && (newValue!.isEditing) {
                                        // Edit button tapped
                                        disableTextField = false
                                    }
                                    else {
                                        // Done button tapped
                                        disableTextField = true
                                    }
                                }
                        }
                        
                        // MARK: ID No.
                        VStack {
                            HStack {
                                Text("ID Number:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Button(action: {
                                    
                                }, label: {
                                    Text("EDIT")
                                        .font(.custom("Avenir", size: 15))
                                        .foregroundColor(green)
                                }).buttonStyle(PlainButtonStyle())
                            }
                            TextField("\(idNum)", text: $idNumber)
                                .disabled(disableTextField)
                                .onChange(of: editMode?.wrappedValue) { newValue in
                                    if (newValue != nil) && (newValue!.isEditing) {
                                        // Edit button tapped
                                        disableTextField = false
                                    }
                                    else {
                                        // Done button tapped
                                        disableTextField = true
                                    }
                                }
                        }
                        
                        // MARK: Email
                        VStack {
                            HStack {
                                Text("Email:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Button(action: {
                                    
                                }, label: {
                                    Text("EDIT")
                                        .font(.custom("Avenir", size: 15))
                                        .foregroundColor(green)
                                }).buttonStyle(PlainButtonStyle())
                            }
                            TextField("\(email)", text: $email)
                                .disabled(disableTextField)
                                .foregroundColor(purple)
                                .onChange(of: editMode?.wrappedValue) { newValue in
                                    if (newValue != nil) && (newValue!.isEditing) {
                                        // Edit button tapped
                                        disableTextField = true
                                    }
                                    else {
                                        // Done button tapped
                                        disableTextField = true
                                    }
                                }
                        }
                        
                        // MARK: Cell No.
                        VStack {
                            HStack {
                                Text("Cell Number:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Button(action: {
                                    
                                }, label: {
                                    Text("EDIT")
                                        .font(.custom("Avenir", size: 15))
                                        .foregroundColor(green)
                                }).buttonStyle(PlainButtonStyle())
                            }
                            TextField("\(cellNum)", text: $cellNum)
                                .disabled(disableTextField)
                                .foregroundColor(purple)
                                .onChange(of: editMode?.wrappedValue) { newValue in
                                    if (newValue != nil) && (newValue!.isEditing) {
                                        // Edit button tapped
                                        disableTextField = true
                                    }
                                    else {
                                        // Done button tapped
                                        disableTextField = true
                                    }
                                }
                        }
                    }
                    
                    Section {
                        Text("To update your User Information above go to: Menu > Account Settings")
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .font(.custom("Avenir", size: 12).bold())
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
                    HStack {
                        Button(action: {
                            self.verifyIdSheetView.toggle()
                        }, label: {
                            HStack {
                                Text("Profile Verification")
                                    .font(.custom("Avenir", size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                
                                Spacer()
                                
                                Image("arrow-right")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding(2)
                            }
                        })
                    }.sheet(isPresented: $verifyIdSheetView) {
                        VerificationDocView()
                    }
                }
            }
            
            Spacer()
        }.navigationTitle("User Information")
            .navigationBarTitleDisplayMode(.inline)
    }
}
