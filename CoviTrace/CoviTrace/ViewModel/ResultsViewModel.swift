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
    
    private var db = Firestore.firestore()
        
    func fetchData() {
        db.collection("results").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No records")
                return
            }
            self.results = documents.map { queryDocumentSnapshot -> TestResults in
                let data = queryDocumentSnapshot.data()
                let testRefNum = data["test_ref_num"] as? String ?? ""
                let testDate = data["date"] as? String ?? ""
                let testResult = data["test_result"] as? String ?? ""
                let testLocation = data["test_location"]  as? String ?? ""
                let labRefNum = data["lab_ref_num"]  as? String ?? ""
                
                return TestResults(testRefNum: testRefNum, labRefNum: labRefNum, testDate: testDate, testResult: testResult, testLocation: testLocation)
            }
        }
    }
}
