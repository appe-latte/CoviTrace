//
//  VaccinationViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 30/04/2021.
//

import Foundation
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
                let vaccCentre = data["vacc_location"] as? String ?? ""
                let firstDoseVaccType = data["1st_dose_vacc_type"] as? String ?? ""
                let secondDoseVaccType = data["2nd_dose_vacc_type"] as? String ?? ""
                let firstDoseDate = data["1st_dose_date"] as? String ?? ""
                let secondDoseDate = data["2nd_dose_date"] as? String ?? ""
                let vaccStatus = data["vacc_status"] as? String ?? ""
                let vaccExpiry = data["vacc_expiry"] as? String ?? ""
                                                
                return VaccineData(id: userid, firstDosebatchNum: firstDosebatchNum, secondDosebatchNum: secondDosebatchNum, vaccCentre: vaccCentre, firstDoseVaccType: firstDoseVaccType, secondDoseVaccType: secondDoseVaccType, firstDoseDate: firstDoseDate, secondDoseDate: secondDoseDate, vaccStatus: vaccStatus, vaccExpiry: vaccExpiry)
            }
        }
    }
}
