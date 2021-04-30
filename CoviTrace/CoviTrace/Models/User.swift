//
//  User.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 29/04/2021.
//

import Firebase

struct User: Identifiable {
    let id: String
    let fName: String
    let lName: String
    let email: String
    let profileImageUrl: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.id }
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.fName = dictionary["First Name"] as? String ?? ""
        self.lName = dictionary["Surname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}

