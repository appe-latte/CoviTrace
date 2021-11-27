//
//  PhoneVerificationViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 26/11/2021.
//

import SwiftUI
import Firebase

class PhoneVerificationViewModel: ObservableObject {
    @Published var mobileNumber = ""
    @Published var verificationCode = ""
    // DataModel for Phone code
    @Published var errorMsg = ""
    @Published var error = false
    
    @Published var CODE = ""     // storage of CODE for verification
    @Published var goToVerify = false // verification
    @AppStorage("log_Status") var status = false // User (login) status
    @Published var loading = false // load view
    
    // MARK: List of country codes for OTP
    func getCountryCode()->String {
        
        let regionCode = Locale.current.regionCode ?? ""
        
        return countries[regionCode] ?? ""
    }
    
    // MARK: code sent to user
    
    func sendCode(){
        
        // MARK: Enable testing code
        
        // MARK: Disable testing code - use with real device
        
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        
        let number = "+\(getCountryCode())\(mobileNumber)"
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) {
            (CODE, err) in
            
            if let error = err {
                self.errorMsg = error.localizedDescription
                withAnimation{ self.error.toggle() }
                return
            }
            
            self.CODE = CODE ?? ""
            self.goToVerify = true
        }
    }
    
    // MARK: Code Verification
    
    func verifyCode() {
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: verificationCode)
        
        loading = true
        Auth.auth().signIn(with: credential) {(result, err) in
            
            self.loading = false
            if let error = err {
                self.errorMsg = error.localizedDescription
                withAnimation{ self.error.toggle() }
                return
            }
            // if authentication is successful
            withAnimation{self.status = true}
        }
    }
    
    func requestCode() {
        sendCode()
        withAnimation{
            self.errorMsg = "A code has been successfully sent to the given number."
            self.error.toggle()
        }
    }
}
