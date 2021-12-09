//
//  User.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 29/04/2021.
//

import Firebase

struct User: Identifiable {
    let id : String
    let firstName : String
    let lastName : String
    let email : String
    let cellNum : String
    let profileImageUrl : String
    let verified : String
    let dob : String
    let idNumber : String
    let regCountry : String
    let idType : String
    let digiCertImageUrl : String
    let vaccCardImageUrl : String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.id }
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.firstName = dictionary["first_name"] as? String ?? ""
        self.lastName = dictionary["surname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.cellNum = dictionary["cell_num"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.verified = dictionary["verified"] as? String ?? ""
        self.dob = dictionary["dob"] as? String ?? ""
        self.idNumber = dictionary["id_num"] as? String ?? ""
        self.regCountry = dictionary["reg_country"] as? String ?? ""
        self.idType = dictionary["id_type"] as? String ?? ""
        self.digiCertImageUrl = dictionary["digiCertImageUrl"] as? String ?? ""
        self.vaccCardImageUrl = dictionary["vaccCardImageUrl"] as? String ?? ""
    }
}

