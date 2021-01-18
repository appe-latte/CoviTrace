//
//  DataFetchRequest.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataFetchRequest: ObservableObject {
    
    init(){
        
        getCovidTotals()
    }
    
    func getCovidTotals() {
        
        let headers: HTTPHeaders = [
            "x-rapidapi-key": "821059debfmsh17dd5446e54ea65p1d449fjsn6706c09ba882",
            "x-rapidapi-host": "covid-19-data.p.rapidapi.com"
        ]
        
        
        AF.request("https://covid-19-data.p.rapidapi.com/country/code?code=gb", headers: headers).responseJSON { response in
            
            let result = response.data
            if result != nil {
                let json = JSON(result!)
                print(json)
            }
            
        }
        
    }
    
    
}
