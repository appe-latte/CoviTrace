//
//  AppLockViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 25/10/2021.
//

import SwiftUI
import LocalAuthentication

class AppLockViewModel: ObservableObject {
    @Published var isAppLockEnabled : Bool = false
    @Published var isAppUnlocked : Bool = false
    
    init() {
        getAppLockState()
    }
    func enableAppLock() {
        UserDefaults.standard.set(true,forKey: UserDefaultsKeys.isAppLockEnabled.rawValue)
        self.isAppLockEnabled = true
    }
    func disableAppLock() {
        UserDefaults.standard.set(false,forKey: UserDefaultsKeys.isAppLockEnabled.rawValue)
        self.isAppLockEnabled = false
    }
    func getAppLockState() {
        isAppLockEnabled = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isAppLockEnabled.rawValue)
    }
    
    func checkIfBioMetricAvailable() -> Bool {
        var error:NSError?
        let laContext = LAContext()
        let isBiometricAvailable = laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let error = error{
            print(error.localizedDescription)
        }
        return isBiometricAvailable
    }
    
    func appLockStateChange(appLockState:Bool) {
        let laContext = LAContext()
        if checkIfBioMetricAvailable(){
            var reason = ""
            if appLockState{
                reason = "To enable the app lock please provide Touch ID / Face ID."
            }
            else{
                reason = "To disable the app lock please provide the Touch ID / Face ID."
            }
            laContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason){ (success,error) in
                if success{
                    if appLockState{
                        DispatchQueue.main.async {
                            self.enableAppLock()
                            self.isAppUnlocked = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.disableAppLock()
                            self.isAppUnlocked = true
                        }
                    }
                } else {
                    if let error = error{
                        DispatchQueue.main.async {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    func appLockValidation(){
        let laContext = LAContext()
        if checkIfBioMetricAvailable(){
            let reason = "Unlock app to view your Covitrace pass."
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){(success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.isAppUnlocked = true
                    }
                } else {
                    if let error = error {
                        DispatchQueue.main.async {
                            print(error.localizedDescription)
                            
                            // <-- add code her to fallback to passcode entry which also resets the Face ID.
                            // Use the toggle button in 'Privacy Settings' to turn Face ID back on.
                        }
                    }
                }
            }
        }
    }
    
}

enum UserDefaultsKeys:String {
    case isAppLockEnabled
}
