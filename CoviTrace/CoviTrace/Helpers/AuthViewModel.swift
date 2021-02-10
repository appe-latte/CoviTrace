//
//  AuthViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    
    // MARK: User Login
    func userLogin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            print("DEBUG: Login successful!")
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
                print("DEBUG: user data successfully uploaded")
                
            }
        }
        
    }
}
