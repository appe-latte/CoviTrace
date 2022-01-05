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
    
    @Published var isError: Bool = false
    @Published var errorMsg: String = ""
    
    @Published var showSaveUserInfoView: Bool = false
    
    init(){
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    // MARK: User Login function
    
    func userLogin(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                self.isError.toggle()
                self.errorMsg = error?.localizedDescription ?? ""
                return
            }
            
            // MARK: Shows Content View after successful login
            self.userSession = result?.user
        }
    }
    
    // MARK: User Registration function
    func userRegistration(email: String, userPwd: String, firstName: String, lastName: String, profileImage: UIImage, verified: String, idNumber: String, cellNum: String, dob: String, regCountry: String, idType: String) {
        guard let imageData = profileImage.jpegData(compressionQuality: 0.6) else { return }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        storageRef.putData(imageData, metadata: nil) { (_, error) in
            if error != nil {
                self.isError.toggle()
                self.errorMsg = error?.localizedDescription ?? ""
                return
            }
            
            // MARK: Upload to Firebase
            storageRef.downloadURL { url, _ in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: userPwd) { result, error in
                    if error != nil {
                        self.isError.toggle()
                        self.errorMsg = error?.localizedDescription ?? ""
                        return
                    }
                    guard let user = result?.user else { return }
                    
                    let data = ["email": email,
                                "first_name": firstName,
                                "surname": lastName,
                                "profileImageUrl": profileImageUrl,
                                "uid": user.uid,
                                "verified": verified,
                                "id_num": idNumber,
                                "cell_num": cellNum,
                                "dob": dob,
                                "reg_country": regCountry,
                                "id_type": idType
                    ]
                    
                    Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                        self.userSession = result?.user
                        self.fetchUser()
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
        
        Firestore.firestore().collection("users").document(uid).addSnapshotListener(includeMetadataChanges: false) { documentSnapshot, error in
            
            if let snapshotData = documentSnapshot?.data() {
                let user = User(dictionary: snapshotData)
                self.user = user
                self.showSaveUserInfoView = false
            } else {
                self.showSaveUserInfoView = true
            }
        }
    }
    
    // MARK: Verify OTP function
    func verifyOTPAndSignIn(verificationID: String?, phoneOTP: String, email: String, firstName: String, lastName: String, profileImage: UIImage, verified: String, idNumber: String, cellNum: String, dob: String, regCountry: String, idType: String) {
        
        if let mVerificationID = verificationID {
            
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: mVerificationID,
                verificationCode: phoneOTP
            )
            
            guard let imageData = profileImage.jpegData(compressionQuality: 0.6) else { return }
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference(withPath: "/profile_images/\(filename)")
            
            storageRef.putData(imageData, metadata: nil) { (_, error) in
                if error != nil {
                    self.isError.toggle()
                    self.errorMsg = error?.localizedDescription ?? ""
                    return
                }
                
                // MARK: Upload to Firebase
                storageRef.downloadURL { url, _ in
                    guard let profileImageUrl = url?.absoluteString else { return }
                    
                    Auth.auth().signIn(with: credential) { (authResult, error) in
                        if let error = error {
                            let authError = error as NSError
                            print(authError.description)
                            return
                        }
                        
                        // MARK: Successful sign-in and authentication
                        let currentUserInstance = Auth.auth().currentUser
                        
                        if let currentUser = currentUserInstance  {
                            
                            let data = ["email": email,
                                        "first_name": firstName,
                                        "surname": lastName,
                                        "profileImageUrl": profileImageUrl,
                                        "uid": currentUser.uid,
                                        "verified": verified,
                                        "id_num": idNumber,
                                        "cell_num": cellNum,
                                        "dob": dob,
                                        "reg_country": regCountry,
                                        "id_type": idType
                            ]
                            
                            Firestore.firestore().collection("users").document(currentUser.uid).setData(data) { _ in
                                self.userSession = currentUser
                                self.fetchUser()
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Verify OTP function
    func verifyOTPAndSignIn(verificationID: String?, phoneOTP: String) {
        
        if let mVerificationID = verificationID {
            
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: mVerificationID,
                verificationCode: phoneOTP
            )
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    let authError = error as NSError
                    print(authError.description)
                    return
                }
                
                // User has signed in successfully and currentUser object is valid
                let currentUserInstance = Auth.auth().currentUser
                
                if let currentUser = currentUserInstance  {
                    print("Logged In \(currentUser.uid)")
                    self.userSession = currentUser
                    self.fetchUser()
                }
            }
        }
    }
    
    // MARK: - Save User info function
    func saveUserInfo(email: String, firstName: String, lastName: String, profileImage: UIImage, verified: String, idNumber: String, cellNum: String, dob: String, regCountry: String, idType: String) {
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.6) else { return }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        storageRef.putData(imageData, metadata: nil) { (_, error) in
            if error != nil {
                self.isError.toggle()
                self.errorMsg = error?.localizedDescription ?? ""
                return
            }
            
            // MARK: Upload to Firebase
            storageRef.downloadURL { url, _ in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                if let userSession = self.userSession {
                    
                    let data = ["email": email,
                                "first_name": firstName,
                                "surname": lastName,
                                "profileImageUrl": profileImageUrl,
                                "uid": userSession.uid,
                                "verified": verified,
                                "id_num": idNumber,
                                "cell_num": "\(userSession.phoneNumber ?? "")",
                                "dob": dob,
                                "reg_country": regCountry,
                                "id_type": idType
                    ]
                    
                    Firestore.firestore().collection("users").document(userSession.uid).setData(data) { _ in
                        self.fetchUser()
                    }
                }
            }
        }
    }
}

