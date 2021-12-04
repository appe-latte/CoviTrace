//
//  Model.swift
//  CoviTrace
//
//  Created by Appè Latte on 18/01/2021.
//

import Foundation
import FirebaseFirestore

struct TestResults: Identifiable, Codable {
    var id : String? = UUID().uuidString
    var testRefNum : String
    var labRefNum : String
    var testDate : String
    var testResult : String
    var testProvider : String
    var userId: String?
    var testVerified: String
    var pcrImageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case testRefNum
        case labRefNum
        case testDate
        case testProvider
        case testResult
        case userId
        case testVerified
        case pcrImageUrl
    }
}

struct FirstVaccineData: Identifiable, Codable {
    var id : String? = UUID().uuidString
    var firstDosebatchNum : String
    var firstDoseVaccType : String
    var firstDoseDate : String
    var userId: String?
    var vaccStatus : String
    var firstDosageLocation : String
    var firstDoseVaccProvider : String
    var firstVaccDoseCountry : String
    var vaccCardVerified : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstDosebatchNum
        case firstDoseVaccType
        case firstDoseDate
        case userId
        case vaccStatus
        case firstDosageLocation
        case firstDoseVaccProvider
        case firstVaccDoseCountry
        case vaccCardVerified
    }
}

struct SecondVaccineData: Identifiable, Codable {
    var id : String? = UUID().uuidString
    var secondDosebatchNum : String
    var secondDoseVaccType : String
    var secondDoseDate : String
    var userId: String?
    var vaccStatus : String
    var secondDosageLocation : String
    var secondDoseVaccProvider : String
    var secondVaccDoseCountry : String
    var vaccCardVerified : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case secondDosebatchNum
        case secondDoseVaccType
        case secondDoseDate
        case userId
        case vaccStatus
        case secondDosageLocation
        case secondDoseVaccProvider
        case secondVaccDoseCountry
        case vaccCardVerified
    }
}

struct BoosterData: Identifiable, Codable {
    var id : String? = UUID().uuidString
    var boosterDosebatchNum : String
    var boosterDoseVaccType : String
    var boosterDoseDate : String
    var userId: String?
    var boosterDoseLocation : String
    var boosterDoseVaccProvider : String
    var boosterDoseCountry : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case boosterDosebatchNum
        case boosterDoseVaccType
        case boosterDoseDate
        case userId
        case boosterDoseLocation
        case boosterDoseVaccProvider
        case boosterDoseCountry
    }
}

struct SingleDoseData: Identifiable, Codable {
    var id : String? = UUID().uuidString
    var singleDosebatchNum : String
    var singleDoseVaccType : String
    var singleDoseDate : String
    var userId: String?
    var singleDoseLocation : String
    var singleDoseVaccProvider : String
    var vaccDoseCountry : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case singleDosebatchNum
        case singleDoseVaccType
        case singleDoseDate
        case userId
        case singleDoseLocation
        case singleDoseVaccProvider
        case vaccDoseCountry
    }
}

struct LocationResults: Identifiable, Codable {
    var id : String? = UUID().uuidString
    var latitude : String
    var longitude : String
    var date : String
    var address: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case latitude
        case longitude
        case date
        case address
    }
}

