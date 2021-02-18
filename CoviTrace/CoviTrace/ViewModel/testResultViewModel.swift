//
//  testResultViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/02/2021.
//

import Foundation
import FirebaseFirestore

class testResultViewModel: ObservableObject {
    @Published var results = [TestResults]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("results").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("nil")
                return
            }
            
            self.results = documents.map { (queryDocumentSnapshot) -> TestResults in
                let data = queryDocumentSnapshot.data()
                let refNum = data["refNum"] as? String ?? ""
                let testCentre = data["testCentre"] as? String ?? ""
                let testDate = data["testDate"] as? String ?? ""
                let testResult = data["testResult"] as? String ?? ""
                return TestResults(refNum: refNum, testCentre: testCentre, testDate: testDate, testResult: testResult)
                
            }
        }
    }
}

