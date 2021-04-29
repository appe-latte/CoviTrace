//
//  ResultsViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 26/03/2021.
//

import Foundation
import Firebase
import FirebaseFirestore

class ResultsViewModel: ObservableObject {
    @Published var results = [TestResults]()
    @Published var results1 = [LocationResults]()
    
    private var db = Firestore.firestore()
    
    func fetchData(id: String) {
        db.collection("results").whereField("userId", in: [id]).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No records")
                return
            }
            self.results = documents.map { queryDocumentSnapshot -> TestResults in
                let data = queryDocumentSnapshot.data()
                let userid = data["userId"] as? String ?? ""
                let testRefNum = data["test_ref_num"] as? String ?? ""
                let testDate = data["date"] as? String ?? ""
                let testResult = data["test_result"] as? String ?? ""
                let testLocation = data["test_location"]  as? String ?? ""
                let labRefNum = data["lab_ref_num"]  as? String ?? ""
                
                return TestResults(testRefNum: testRefNum, labRefNum: labRefNum, testDate: testDate, testResult: testResult, testLocation: testLocation, userId: userid)
            }
        }
    }
    
    func fetchLocationData(id: String) {
        db.collection("checkins").whereField("userId", in: [id]).addSnapshotListener { [self] (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No records")
                return
            }
            
            let arr  = documents.map { queryDocumentSnapshot -> LocationResults in
                let data = queryDocumentSnapshot.data()
                let latitude = data["latitude"] as? String ?? ""
                let longitude = data["longitude"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                return LocationResults(latitude: latitude, longitude: longitude, date: date, address: address)
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            self.results1 = arr.sorted(by: { dateFormatter.date(from: $0.date)!.compare(dateFormatter.date(from: $1.date)!) == .orderedDescending })
        }
    }
}
