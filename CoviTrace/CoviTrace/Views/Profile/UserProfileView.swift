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
    
    @ObservedObject var authModel = AuthViewModel()
    @State var rowHeight = 50.0
    
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
                    
                    Section {
                        // MARK: Name
                        VStack(spacing: 10) {
                            HStack {
                                Text("Name:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Text(fullName)
                                    .font(.custom("Avenir", size: 17).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            }
                        }
                        
                        // MARK: DoB
                        VStack {
                            HStack {
                                Text("Date of Birth:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Text(dob)
                                    .font(.custom("Avenir", size: 17).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            }
                        }
                        
                        // MARK: ID No.
                        VStack {
                            HStack {
                                Text("ID Number:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Text(idNum)
                                    .font(.custom("Avenir", size: 17).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            }
                        }
                        
                        // MARK: Email
                        VStack {
                            HStack {
                                Text("Email:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Text(email)
                                    .font(.custom("Avenir", size: 17).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            }
                        }
                        
                        // MARK: Cell No.
                        VStack {
                            HStack {
                                Text("Cell Number:")
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Text(cellNum)
                                    .font(.custom("Avenir", size: 17).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            }
                        }
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
                }
                .environment(\.defaultMinListRowHeight, rowHeight)
            }
            
            Spacer()
        }
        .navigationTitle("User Information")
        .navigationBarTitleDisplayMode(.inline)
    }
}
