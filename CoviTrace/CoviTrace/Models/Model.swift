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
    var testLocation : String
    var userId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case testRefNum
        case labRefNum
        case testDate
        case testLocation
        case testResult
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

struct CovidData: Identifiable {
    var id : String? = UUID().uuidString
    var date: String?
    var areaName : String?
    var areaCode : String?
    var newCasesByPublishDate : String?
    var cumCasesByPublishDate : String?
    var newDeathsByDeathDate : String?
    var cumDeathsByDeathDate : String?
}

struct VaccineData: Identifiable {
    var id: String?
    var batchNum : String
    var vaccDate : Date
    var vaccCentre : String
    var vaccType : String
    var firstDosageDate : Date
    var secondDosageDate : Date
    var userId: String?
}

struct DailyCovidData {
    let confirmed : Int
    let deaths : Int
    let recovered : Int
    let critical : Int
}

struct TotalData {
    let confirmed : Int
    let critical : Int
    let deaths : Int
    let recovered : Int
    
    var fatalityRate : Double {
        return (100.00 * Double(deaths)) / (Double(confirmed))
    }
    
    var recoveryRate : Double {
        return (100.00 * Double(recovered)) / (Double(confirmed))
    }
}

struct CountryData {
    
    let country : String
    let critical : Int64
    let deaths : Int64
    let recovered : Int64
    let longitude : Double
    let latitude : Double
    let confirmed : Int
    
    var fatalityRate : Double {
        return (100.00 * Double(deaths)) / (Double(confirmed))
    }
    
    var recoveryRate : Double {
        return (100.00 * Double(recovered)) / (Double(confirmed))
    }
}

let testDailyCovidData = DailyCovidData(confirmed: 0, deaths: 0, recovered: 0, critical: 0)
let testTotalData = TotalData(confirmed: 0, critical: 0, deaths: 1, recovered: 0)
let testCountryData = CountryData(country: "Test", critical: 1, deaths: 0, recovered: 0, longitude: 0, latitude: 0, confirmed: 0)
