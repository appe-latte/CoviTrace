//
//  AuthViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI
import Firebase
import UIKit

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticating = false // blocks buttons and textfields during authentication
    @Published var error: Error? // Displays error message
    @Published var user: User? // Keeps track of the user
    
    init(){
        userSession = Auth.auth().currentUser
    }
    
    // MARK: User Login function
    
    func userLogin(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Login failed \(error.localizedDescription)")
                return
            }
            self.userSession = result?.user
        }
    }
    
    // MARK: User Registration function
    
    func userRegistration(email: String, userPwd: String, firstName: String, lastName: String, profileImage: UIImage) {
        Auth.auth().createUser(withEmail: email, password: userPwd) { result, error in
            if let error = error {
                print("DEBUG: Registration Error \(error.localizedDescription)")
                return
            }
            
            guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child(filename)
            
        }
    }

    // MARK:  Sign Out function
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
}
