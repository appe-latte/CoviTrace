//
//  VaccinationViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 30/04/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class VaccinationViewModel: ObservableObject {
    @Published var results = [VaccineData]()
    
    private var db = Firestore.firestore()
    
    func fetchData(id: String) {
        db.collection("vaccinations").whereField("userId", in: [id]).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No records")
                return
            }
            self.results = documents.map { queryDocumentSnapshot -> VaccineData in
                let data = queryDocumentSnapshot.data()
                let userid = data["userId"] as? String ?? ""
                let firstDosebatchNum = data["1st_dose_batch_num"] as? String ?? ""
                let secondDosebatchNum = data["2nd_dose_batch_num"] as? String ?? ""
                let firstDoseVaccType = data["1st_dose_vacc_type"] as? String ?? ""
                let secondDoseVaccType = data["2nd_dose_vacc_type"] as? String ?? ""
                let firstDoseDate = data["1st_dose_date"] as? String ?? ""
                let secondDoseDate = data["2nd_dose_date"] as? String ?? ""
                let vaccStatus = data["vacc_status"] as? String ?? ""
                let vaccExpiry = data["vacc_expiry"] as? String ?? ""
                let firstDosageLocation = data["1st_issued_by"] as? String ?? ""
                let secondDosageLocation = data["2nd_issued_by"] as? String ?? ""
                let firstDoseVaccProvider = data["1st_provider"] as? String ?? ""
                let secondDoseVaccProvider = data["2nd_provider"] as? String ?? ""
                let shotType = data["shot_type"] as? String ?? ""
                let vaccDoseCountry = data["vacc_dose_country"] as? String ?? ""
                let vaccCardVerified = data["vacc_card_verified"] as? String ?? ""
                                                
                return VaccineData(id: userid, firstDosebatchNum: firstDosebatchNum, secondDosebatchNum: secondDosebatchNum, firstDoseVaccType: firstDoseVaccType, secondDoseVaccType: secondDoseVaccType, firstDoseDate: firstDoseDate, secondDoseDate: secondDoseDate, vaccStatus: vaccStatus, vaccExpiry: vaccExpiry, firstDosageLocation: firstDosageLocation, secondDosageLocation: secondDosageLocation, firstDoseVaccProvider: firstDoseVaccProvider, secondDoseVaccProvider: secondDoseVaccProvider, shotType: shotType, vaccDoseCountry: vaccDoseCountry, vaccCardVerified: vaccCardVerified)
            }
        }
    }
}
