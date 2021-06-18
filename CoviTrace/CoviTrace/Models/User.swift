//
//  User.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 29/04/2021.
//

import Firebase
import SwiftUI

struct User: Identifiable {
    let id : String
    let fName : String
    let lName : String
    let email : String
    let profileImageUrl : String
    let verified : String
    let dob : String
    let patientNumber : String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.id }
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.fName = dictionary["First Name"] as? String ?? ""
        self.lName = dictionary["Surname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.verified = dictionary["verified"] as? String ?? ""
        self.dob = dictionary["dob"] as? String ?? ""
        self.patientNumber = dictionary["patientNum"] as? String ?? ""
    }
}

