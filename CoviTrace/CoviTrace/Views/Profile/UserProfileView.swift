//
//  UserProfileView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 29/04/2021.
//

import SwiftUI
import Firebase

struct UserProfileView: View {
        @ObservedObject var authModel = AuthViewModel()
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                ProfileHeaderView(authModel: AuthViewModel())
            }
        }
    }
}
