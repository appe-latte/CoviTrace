//
//  BoosterShotViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 20/10/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class BoosterShotViewModel: ObservableObject {
    @Published var boosterData = [BoosterData]()
    
    private var db = Firestore.firestore()
    
    func fetchData(id: String) {
        db.collection("booster").whereField("userId", in: [id]).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No records")
                return
            }
            self.boosterData = documents.map { queryDocumentSnapshot -> BoosterData in
                let data = queryDocumentSnapshot.data()
                let userid = data["userId"] as? String ?? ""
                let boosterDosebatchNum = data["booster_batch_num"] as? String ?? ""
                let boosterDoseVaccType = data["booster_vacc_type"] as? String ?? ""
                let boosterDoseDate = data["booster_date"] as? String ?? ""
                let boosterDoseLocation = data["booster_issued_by"] as? String ?? ""
                let boosterDoseVaccProvider = data["booster_provider"] as? String ?? ""
                let boosterDoseCountry = data["booster_dose_country"] as? String ?? ""
                
                return BoosterData(id: userid, boosterDosebatchNum: boosterDosebatchNum, boosterDoseVaccType: boosterDoseVaccType, boosterDoseDate: boosterDoseDate, boosterDoseLocation: boosterDoseLocation, boosterDoseVaccProvider: boosterDoseVaccProvider, boosterDoseCountry: boosterDoseCountry)
            }
        }
    }
}
