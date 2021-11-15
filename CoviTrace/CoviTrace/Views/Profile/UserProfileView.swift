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
            Background()
            VStack {
                Text("Profile goes here...")
                    .foregroundColor(Color.white)
                    .font(.system(size: 14))
            }
        }
    }
}
