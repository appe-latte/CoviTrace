//
//  AuthViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    
    func login(email: String, password: String) {
        
    }
    
    func userSignUp(firstName: String, lastName: String, email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            print("DEBUG: Registration was successful!")
        }
        
    }
}
