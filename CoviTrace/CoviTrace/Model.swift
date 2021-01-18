//
//  Model.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
//

import Foundation

struct DailyStatistics {
    
    let confirmed: Int;
    let critical : Int;
    let lastUpdate : Date;
    let latitude : Double;
    let longitude : Double;
    let recovered : Int;
    let country: String;
}
