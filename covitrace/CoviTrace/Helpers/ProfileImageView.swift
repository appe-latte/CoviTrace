//
//  ProfileImageView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2022.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ProfileImageView: View {
    @EnvironmentObject var authModel : AuthViewModel

    var body: some View {
        ZStack {
            Image(systemName: "person.crop.circle.fill")
                .data(url: URL(string: "\(authModel.user?.profileImageUrl ?? "")")!)
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .frame(width: 300, height: 200)
                .clipShape(Circle())
        }
    }
}
