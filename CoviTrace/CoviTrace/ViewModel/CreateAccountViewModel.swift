//
//  CreateAccountViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 23/09/2021.
//

import SwiftUI
import Combine
import Firebase

class CreateAccountViewModel: NSObject, ObservableObject {
    // User Details
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var idNumber = ""
    @Published var dob = ""
    @Published var cellNum = ""
    @Published var otpCode = ""
    
    @Published var pageNumber = 0
    @Published var profileImageUrl = Array(repeating: Data(count: 0), count: 1)
    
    @Published var picker = false
    
    // View Alert
    @Published var alert = false
    @Published var alertMsg = ""
    
    // Loading Screen
    @Published var isLoading = false
    
    // OTP Credentials...
    @Published var CODE = ""
    
    // Status...
    @AppStorage("log_Status") var status = false
    
    // MARK: Login Function
    
    func login(){
        
        // Getting OTP...
        // Disabling App Verification...
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true // Disbale when using live device
        
        isLoading.toggle()
        
        PhoneAuthProvider.provider().verifyPhoneNumber("+" + otpCode + cellNum, uiDelegate: nil) { (CODE, err) in
            
            self.isLoading.toggle()
            
            if err != nil{
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            self.CODE = CODE!
            
            // MARK: Alert View
            
            let alertView = UIAlertController(title: "Verification", message: "Enter OTP Code", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            
            let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
                
                // MARK: OTP verification
                
                if let otp = alertView.textFields![0].text{
                    
                    let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: otp)
                    
                    self.isLoading.toggle()
                    
                    Auth.auth().signIn(with: credential) { (res, err) in
                        
                        if err != nil{
                            self.alertMsg = err!.localizedDescription
                            self.alert.toggle()
                            self.isLoading.toggle()
                            return
                        }
                        
                        // Go To Register Screen....
                        withAnimation{
                            self.pageNumber = 1
                        }
                        
                        self.isLoading.toggle()
                    }
                }
            }
            
            alertView.addTextField { (txt) in
                txt.placeholder = "1234"
            }
            
            alertView.addAction(cancel)
            alertView.addAction(ok)
            
            // MARK: View Alert is presented
            
            UIApplication.shared.windows.first?.rootViewController?.present(alertView, animated: true, completion: nil)
        }
    }
    
    // MARK: Sign Up Function
    
    func signUp(){
        
        let storage = Storage.storage().reference()
        
        let ref = storage.child("profileImageUrl").child(Auth.auth().currentUser!.uid)

        var urls : [String] = [] // Image URL
        
        isLoading.toggle()
        
        for index in profileImageUrl.indices{
                        
            ref.child("img\(index)").putData(profileImageUrl[index], metadata: nil) { (_, err) in
                                
                if err != nil{
                    self.alertMsg = err!.localizedDescription
                    self.alert.toggle()
                    self.isLoading.toggle()
                    return
                }
                
                ref.child("img\(index)").downloadURL { (url, _) in
                    guard let imageUrl = url else{return}
                    
                    //appdending urls...
                    urls.append("\(imageUrl)")
                    
                    // checking all images are uploaded...
                    if urls.count == self.profileImageUrl.count{
                        
                        // Update DB...
                        self.UserRegistration(urls: urls)
                    }
                }
                
            }
        }
    }
    
    // MARK: User Registration Function
    
    func UserRegistration(urls: [String]){
        
        let db = Firestore.firestore()
        
        db.collection("users").document(Auth.auth().currentUser!.uid).setData([
            "Cell": self.cellNum,
            "First Name": self.firstName,
            "Surname": self.lastName,
            "profileImageUrl": profileImageUrl,
            "dob": self.dob,
            "ID_Number": self.idNumber
            
        ]) { (err) in
            
            self.isLoading.toggle()
            
            if err != nil{
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            // Success..
            self.status = true
        }
    }
}

