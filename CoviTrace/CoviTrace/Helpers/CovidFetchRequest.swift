//
//  CovidFetchRequest.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class CovidFetchRequest: ObservableObject {
    @Published var allCountries: [CountryData] = []
    @Published var totalData: TotalData = testTotalData
    @Published var dailyData: DailyCovidData = testDailyCovidData
    
    init(){
        
        getCovidTotals()
    }
    
    func getCovidTotals() {
        
        let headers: HTTPHeaders = [
            "x-rapidapi-key": "821059debfmsh17dd5446e54ea65p1d449fjsn6706c09ba882",
            "x-rapidapi-host": "covid-19-data.p.rapidapi.com"
        ]
        
        AF.request("https://covid-19-data.p.rapidapi.com/country/code?date=2020-12-01&code=gb", headers: headers).responseJSON { response in
            
            let result = response.data
            
            if result != nil {
                let json = JSON(result!)
//                print(json)
                let confirmed = json[0]["confirmed"].intValue
                let deaths = json[0]["deaths"].intValue
                let critical = json[0]["critical"].intValue
                let recovered = json[0]["recovered"].intValue
                
                self.totalData = TotalData(confirmed: confirmed, critical: critical, deaths: deaths, recovered: recovered)
                self.dailyData = DailyCovidData(confirmed: confirmed, deaths: deaths, recovered: recovered, critical: critical)
            
            } else {
//                self.totalData = testTotalData
                self.dailyData = testDailyCovidData
            }
            
        }
        
    }

}
