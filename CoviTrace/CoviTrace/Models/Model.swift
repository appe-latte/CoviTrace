//
//  Model.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
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
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case testRefNum
        case labRefNum
        case testDate
        case testProvider
        case testResult
        case userId
        case testVerified
        case image
    }
}

struct VaccineData: Identifiable, Codable {
    var id : String? = UUID().uuidString
    var firstDosebatchNum : String
    var secondDosebatchNum : String
    var firstDoseVaccType : String
    var secondDoseVaccType : String
    var firstDoseDate : String
    var secondDoseDate : String
    var userId: String?
    var vaccStatus : String
    var vaccExpiry : String
    var firstDosageLocation : String
    var secondDosageLocation : String
    var firstDoseVaccProvider : String
    var secondDoseVaccProvider : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstDosebatchNum
        case secondDosebatchNum
        case firstDoseVaccType
        case secondDoseVaccType
        case firstDoseDate
        case secondDoseDate
        case userId
        case vaccStatus
        case vaccExpiry
        case firstDosageLocation
        case secondDosageLocation
        case firstDoseVaccProvider
        case secondDoseVaccProvider
    }
}

struct AppointData: Identifiable, Codable {
    var id: String? = UUID().uuidString
    var appointDate : String
    var appointTitle : String
    var appointLocation : String
    var userId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case appointDate
        case appointTitle
        case appointLocation
        case userId
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

