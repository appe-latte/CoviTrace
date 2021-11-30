//
//  VaccinationViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 30/04/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class FirstDoseVaccViewModel: ObservableObject {
    @Published var firstDoseData = [FirstVaccineData]()
    
    private var db = Firestore.firestore()
    
    func fetchData(id: String) {
        db.collection("first_dose").whereField("userId", in: [id]).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No records")
                return
            }
            self.firstDoseData = documents.map { queryDocumentSnapshot -> FirstVaccineData in
                let data = queryDocumentSnapshot.data()
                let userid = data["userId"] as? String ?? ""
                let firstDosebatchNum = data["1st_dose_batch_num"] as? String ?? ""
                let firstDoseVaccType = data["1st_dose_vacc_type"] as? String ?? ""
                let firstDoseDate = data["1st_dose_date"] as? String ?? ""
                let vaccStatus = data["vacc_status"] as? String ?? ""
                let firstDosageLocation = data["1st_issued_by"] as? String ?? ""
                let firstDoseVaccProvider = data["1st_provider"] as? String ?? ""
                let firstVaccDoseCountry = data["1st_vacc_dose_country"] as? String ?? ""
                let vaccCardVerified = data["vacc_card_verified"] as? String ?? ""
                                                
                return FirstVaccineData(id: userid, firstDosebatchNum: firstDosebatchNum, firstDoseVaccType: firstDoseVaccType, firstDoseDate: firstDoseDate, vaccStatus: vaccStatus, firstDosageLocation: firstDosageLocation, firstDoseVaccProvider: firstDoseVaccProvider, firstVaccDoseCountry : firstVaccDoseCountry, vaccCardVerified: vaccCardVerified)
            }
        }
    }
}
