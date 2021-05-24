//
//  AuthViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI
import Firebase
import Combine

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User? // tracks if user is logged in
    @Published var isAuthenticating = false // blocks buttons and textfields during authentication
    @Published var error: Error? // Displays error message
    @Published var user: User? // Keeps track of the user
    
    init(){
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    // MARK: User Login function
    
    func userLogin(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Login Failed: \(error.localizedDescription)!")
                return
            }
            //            print("DEBUG: Successfully logged in!")
            
            // MARK: Shows Content View after successful login
            self.userSession = result?.user
        }
    }
    
    // MARK: User Registration function
    
    func userRegistration(email: String, userPwd: String, firstName: String, lastName: String, profileImage: UIImage, verified: String) {
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (_, error) in
            if let error = error {
                print("DEBUG: Image upload failed \(error.localizedDescription)!")
                return
            }
            print("DEBUG: Successfully uploaded profile image!")
            
            // MARK: Upload to Firebase
            storageRef.downloadURL { url, _ in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: userPwd) { result, error in
                    if let error = error {
                        print("DEBUG: Registration Error \(error.localizedDescription)!")
                        return
                    }
                    guard let user = result?.user else { return }
                    
                    let data = ["email": email,
                                "First Name": firstName,
                                "Surname": lastName,
                                "profileImageUrl": profileImageUrl,
                                "uid": user.uid,
                                "verified": verified]
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                        //                        print("DEBUG: Successfully uploaded user data!")
                        // MARK: Moves to Content View after registration
                        self.userSession = result?.user
                        
                    }
                }
            }
        }
    }
    
    // MARK:  Sign Out function
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    // MARK: Fetch User function
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let data = snapshot?.data() else { return }
            let user = User(dictionary: data)
//            print("DEBUG: The user is: \(user.fName)")
            self.user = user
        }
    }
}
