//
//  SecondDoseVaccViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 28/11/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class SecondDoseVaccViewModel: ObservableObject {
    @Published var secondDoseData = [SecondVaccineData]()
    
    private var db = Firestore.firestore()
    
    func fetchData(id: String) {
        db.collection("second_dose").whereField("userId", in: [id]).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No records")
                return
            }
            self.secondDoseData = documents.map { queryDocumentSnapshot -> SecondVaccineData in
                let data = queryDocumentSnapshot.data()
                let userid = data["userId"] as? String ?? ""
                let secondDosebatchNum = data["2nd_dose_batch_num"] as? String ?? ""
                let secondDoseVaccType = data["2nd_dose_vacc_type"] as? String ?? ""
                let secondDoseDate = data["2nd_dose_date"] as? String ?? ""
                let vaccStatus = data["vacc_status"] as? String ?? ""
                let secondDosageLocation = data["2nd_issued_by"] as? String ?? ""
                let secondDoseVaccProvider = data["2nd_provider"] as? String ?? ""
                let secondVaccDoseCountry = data["2nd_vacc_dose_country"] as? String ?? ""
                let vaccCardVerified = data["vacc_card_verified"] as? String ?? ""
                                                
                return SecondVaccineData(id: userid, secondDosebatchNum: secondDosebatchNum, secondDoseVaccType: secondDoseVaccType, secondDoseDate: secondDoseDate, vaccStatus: vaccStatus, secondDosageLocation: secondDosageLocation, secondDoseVaccProvider: secondDoseVaccProvider, secondVaccDoseCountry: secondVaccDoseCountry, vaccCardVerified: vaccCardVerified)
            }
        }
    }
}
