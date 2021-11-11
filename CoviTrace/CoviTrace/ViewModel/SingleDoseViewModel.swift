//
//  SingleDoseViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 26/10/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class SingleDoseViewModel: ObservableObject {
    @Published var singleDoseData = [SingleDoseData]()
    
    private var db = Firestore.firestore()
    
    func fetchData(id: String) {
        db.collection("single_dose").whereField("userId", in: [id]).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No records")
                return
            }
            self.singleDoseData = documents.map { queryDocumentSnapshot -> SingleDoseData in
                let data = queryDocumentSnapshot.data()
                let userid = data["userId"] as? String ?? ""
                let singleDosebatchNum = data["single_batch_num"] as? String ?? ""
                let singleDoseVaccType = data["single_vacc_type"] as? String ?? ""
                let singleDoseDate = data["single_date"] as? String ?? ""
                let singleDoseLocation = data["single_issued_by"] as? String ?? ""
                let singleDoseVaccProvider = data["single_provider"] as? String ?? ""
                let vaccDoseCountry = data["vacc_dose_country"] as? String ?? ""
                let shotType = data["shot_type"] as? String ?? ""
                
                return SingleDoseData(id: userid, singleDosebatchNum : singleDosebatchNum, singleDoseVaccType : singleDoseVaccType, singleDoseDate : singleDoseDate, singleDoseLocation : singleDoseLocation, singleDoseVaccProvider : singleDoseVaccProvider, vaccDoseCountry : vaccDoseCountry, shotType: shotType)
            }
        }
    }
}
