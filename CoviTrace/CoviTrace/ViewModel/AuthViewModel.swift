//
//  AuthViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticating = false // blocks buttons and textfields during authentication
    @Published var error: Error? // Displays error message
    @Published var user: User? // Keeps track of the user
    
    init(){
        userSession = Auth.auth().currentUser
    }
    
    // MARK: User Login
    func userLogin(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Login failed \(error.localizedDescription)")
                return
            }
            self.userSession = result?.user
        }
    }
    
    // MARK: User Registration
    func userSignUp(firstName: String, lastName: String, email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Error \(error.localizedDescription)")
                return
            }
            // MARK: User data upload
            guard let user = result?.user else {return}
            
            let data = ["Email": email,
                        "First Name": firstName,
                        "Last Name": lastName,
                        "uid": user.uid]
            
            Firestore.firestore().collection("users").document(user.uid).setData(data){ _ in
                self.userSession = result?.user // moves to main screen after authentication
                
            }
        }
    }
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
}
