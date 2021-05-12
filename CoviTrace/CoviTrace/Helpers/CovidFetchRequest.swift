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
    @Published var covidDataEngland: [CovidData] = []
    @Published var covidDataScotland: [CovidData] = []
    @Published var covidDataWales: [CovidData] = []
    
    let headers: HTTPHeaders = [
        "x-rapidapi-key": "821059debfmsh17dd5446e54ea65p1d449fjsn6706c09ba882",
        "x-rapidapi-host": "covid-19-data.p.rapidapi.com"
    ]
    
    init(){
        
        getCovidTotals()
    }
    
    func getCovidTotals() {
        
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
                self.dailyData = testDailyCovidData
            }
        }
    }
    
    func getCovidDataEngland()
    {
        self.covidDataEngland = []
        
        let queryParams: [String: String] = [
            "filters": "areaType=nation;areaName=england;date=" + yesterDay(),
            "structure": "{\"date\": \"date\",\"areaName\": \"areaName\",\"areaCode\": \"areaCode\",\"newCasesByPublishDate\": \"newCasesByPublishDate\",\"cumCasesByPublishDate\": \"cumCasesByPublishDate\",\"newDeathsByDeathDate\": \"newDeathsByDeathDate\",\"cumDeathsByDeathDate\": \"cumDeathsByDeathDate\"}"
        ]
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.coronavirus.data.gov.uk"
        urlComponents.path = "/v1/data"
        urlComponents.setQueryItems(with: queryParams)
        
        AF.request(urlComponents.url!.absoluteString).responseJSON { response in
            if response != nil {
                let json = JSON(response.data)
                let arr = json["data"]
                for i in 0..<arr.count  {
                    let date = json["data"][i]["date"].stringValue
                    let areaName = json["data"][i]["areaName"].stringValue
                    let areaCode = json["data"][i]["areaCode"].stringValue
                    let newCasesByPublishDate = json["data"][i]["newCasesByPublishDate"].stringValue
                    let cumCasesByPublishDate = json["data"][i]["cumCasesByPublishDate"].stringValue
                    let newDeathsByDeathDate = json["data"][i]["newDeathsByDeathDate"].stringValue
                    let cumDeathsByDeathDate = json["data"][i]["cumDeathsByDeathDate"].stringValue
                    self.covidDataEngland.append(CovidData(date: date, areaName: areaName, areaCode: areaCode, newCasesByPublishDate: newCasesByPublishDate, cumCasesByPublishDate: cumCasesByPublishDate, newDeathsByDeathDate: newDeathsByDeathDate, cumDeathsByDeathDate: cumDeathsByDeathDate))
                }
            }
        }
    }
    
    func getCovidDataScotland()
    {
        self.covidDataScotland = []
        let queryParams: [String: String] = [
            "filters": "areaType=nation;areaName=scotland;date=" + yesterDay(),
            "structure": "{\"date\": \"date\",\"areaName\": \"areaName\",\"areaCode\": \"areaCode\",\"newCasesByPublishDate\": \"newCasesByPublishDate\",\"cumCasesByPublishDate\": \"cumCasesByPublishDate\",\"newDeathsByDeathDate\": \"newDeathsByDeathDate\",\"cumDeathsByDeathDate\": \"cumDeathsByDeathDate\"}"
        ]
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.coronavirus.data.gov.uk"
        urlComponents.path = "/v1/data"
        urlComponents.setQueryItems(with: queryParams)
        
        AF.request(urlComponents.url!.absoluteString).responseJSON { response in
            if response != nil {
                let json = JSON(response.data)
                let arr = json["data"]
                for i in 0..<arr.count  {
                    let date = json["data"][i]["date"].stringValue
                    let areaName = json["data"][i]["areaName"].stringValue
                    let areaCode = json["data"][i]["areaCode"].stringValue
                    let newCasesByPublishDate = json["data"][i]["newCasesByPublishDate"].stringValue
                    let cumCasesByPublishDate = json["data"][i]["cumCasesByPublishDate"].stringValue
                    let newDeathsByDeathDate = json["data"][i]["newDeathsByDeathDate"].stringValue
                    let cumDeathsByDeathDate = json["data"][i]["cumDeathsByDeathDate"].stringValue
                    self.covidDataScotland.append(CovidData(date: date, areaName: areaName, areaCode: areaCode, newCasesByPublishDate: newCasesByPublishDate, cumCasesByPublishDate: cumCasesByPublishDate, newDeathsByDeathDate: newDeathsByDeathDate, cumDeathsByDeathDate: cumDeathsByDeathDate))
                }
            }
        }
    }
    
    func getCovidDataWales()
    {
        self.covidDataWales = []
        let queryParams: [String: String] = [
            "filters": "areaType=nation;areaName=Wales;date=" + yesterDay(),
            "structure": "{\"date\": \"date\",\"areaName\": \"areaName\",\"areaCode\": \"areaCode\",\"newCasesByPublishDate\": \"newCasesByPublishDate\",\"cumCasesByPublishDate\": \"cumCasesByPublishDate\",\"newDeathsByDeathDate\": \"newDeathsByDeathDate\",\"cumDeathsByDeathDate\": \"cumDeathsByDeathDate\"}"
        ]
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.coronavirus.data.gov.uk"
        urlComponents.path = "/v1/data"
        urlComponents.setQueryItems(with: queryParams)
        
        AF.request(urlComponents.url!.absoluteString).responseJSON { response in
            if response != nil {
                let json = JSON(response.data)
                let arr = json["data"]
                for i in 0..<arr.count  {
                    let date = json["data"][i]["date"].stringValue
                    let areaName = json["data"][i]["areaName"].stringValue
                    let areaCode = json["data"][i]["areaCode"].stringValue
                    let newCasesByPublishDate = json["data"][i]["newCasesByPublishDate"].stringValue
                    let cumCasesByPublishDate = json["data"][i]["cumCasesByPublishDate"].stringValue
                    let newDeathsByDeathDate = json["data"][i]["newDeathsByDeathDate"].stringValue
                    let cumDeathsByDeathDate = json["data"][i]["cumDeathsByDeathDate"].stringValue
                    self.covidDataWales.append(CovidData(date: date, areaName: areaName, areaCode: areaCode, newCasesByPublishDate: newCasesByPublishDate, cumCasesByPublishDate: cumCasesByPublishDate, newDeathsByDeathDate: newDeathsByDeathDate, cumDeathsByDeathDate: cumDeathsByDeathDate))
                }
            }
        }
    }
    
    func yesterDay() -> String {
        var dayComponent = DateComponents()
        dayComponent.day = -1
        let calendar = Calendar.current
        let nextDay =  calendar.date(byAdding: dayComponent, to: Date())!
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: nextDay)
    }
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}


