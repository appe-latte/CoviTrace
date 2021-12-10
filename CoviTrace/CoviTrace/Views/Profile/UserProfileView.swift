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
    
    @State private var updateProfileSheetView = false
    @State private var showVaccCardView = false
    
    @ObservedObject var authModel = AuthViewModel()
    
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
                        HStack {
                            Text("Name:")
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            Spacer()
                            Text(fullName)
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        }
                        
                        HStack {
                            Text("Date of Birth:")
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            Spacer()
                            Text(dob)
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        }
                        
                        HStack {
                            Text("ID Number:")
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            Spacer()
                            Text(idNum)
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        }
                        
                        HStack {
                            Text("Email:")
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            Spacer()
                            Text(email)
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        }
                        
                        HStack {
                            Text("Cell Number:")
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            Spacer()
                            Text(cellNum)
                                .font(.custom("Avenir", size: 15).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
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
                }
            }
            
            Spacer()
        }.navigationTitle("User Information")
            .navigationBarTitleDisplayMode(.inline)
    }
}
