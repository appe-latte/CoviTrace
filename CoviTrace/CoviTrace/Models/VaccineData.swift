//
//  VaccineData.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/03/2021.
//

import SwiftUI
import FirebaseFirestore

struct VaccineData: Identifiable {
    var id: ObjectIdentifier
    var batchNum : String
    var vaccDate : Date
    var vaccCentre : String
    var vaccType : String
    var firstDosageDate : Date
    var secondDosageDate : Date
}
