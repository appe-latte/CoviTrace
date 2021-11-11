//
//  ProfileHeaderView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 29/04/2021.
//

import SwiftUI
import Firebase

struct ProfileHeaderView: View {
    @ObservedObject var authModel : AuthViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 10){
                let fullName = authModel.user!.firstName + authModel.user!.lastName
                let dob = authModel.user!.dob
                let userIdNum = authModel.user!.idNumber
//                let email = authModel.user!.email
                
                Form {
                    Section(header: Text("")){
                        List() {
                            
                            // MARK: Profile Image
                            Image(systemName: "person.crop.circle.fill")
                                .data(url: URL(string: "\(authModel.user!.profileImageUrl)")!)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 300, height: 200)
                                .foregroundColor(Color(.white))
                                .padding(5)
                            
                            // MARK: User name
                            HStack {
                                Text("Name:")
                                    .font(.subheadline)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                Spacer()
                                Text(fullName)
                                    .font(.subheadline)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            }
                            
                            // MARK: User DOB
                            HStack {
                                Text("DOB:")
                                    .font(.subheadline)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                Spacer()
                                Text(dob)
                                    .font(.subheadline)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            }
                            
                            // MARK: User ID Number
                            HStack {
                                Text("ID Number:")
                                    .font(.subheadline)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                Spacer()
                                Text(userIdNum)
                                    .font(.subheadline)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            }
                        }
                    }
                }.padding(10)
            }
        }
    }
}
