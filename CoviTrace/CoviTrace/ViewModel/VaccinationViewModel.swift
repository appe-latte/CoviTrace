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
                let batchNum = data["vacc_batch_num"] as? String ?? ""
                let vaccDate = data["vaccination_date"] as? String ?? ""
                let vaccCentre = data["vaccine_centre"] as? String ?? ""
                let vaccType = data["vaccine_type"]  as? String ?? ""
                let firstDosageDate = data["first_dosage"]  as? String ?? ""
                let secondDosageDate = data["second_dosage"]  as? String ?? ""
                                
                return VaccineData(batchNum: batchNum, vaccDate: vaccDate, vaccCentre: vaccCentre, vaccType: vaccType, firstDosageDate: firstDosageDate, secondDosageDate: secondDosageDate, userId: userid)
            }
        }
    }
}
