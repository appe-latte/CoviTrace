//
//  UserProfileView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 29/04/2021.
//

import SwiftUI
import Firebase

struct UserProfileView: View {
    @EnvironmentObject var authModel : AuthViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Text("Profile goes here...")
                    .bold()
                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
            }
        }.navigationTitle("User Information")
            .navigationBarTitleDisplayMode(.inline)
    }
}
