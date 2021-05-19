//
//  AppointmentViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 04/05/2021.
//

import SwiftUI
import FirebaseFirestore
import Firebase

class AppointmentViewModel : ObservableObject {
    @Published var appointments = [AppointData]()
    
    private var db = Firestore.firestore()
    
    func fetchData(id: String) {
        db.collection("appointments").whereField("userId", in: [id]).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No records")
                return
            }
            self.appointments = documents.map { queryDocumentSnapshot -> AppointData in
                let data = queryDocumentSnapshot.data()
                let userid = data["userId"] as? String ?? ""
                let appointDate = data["appoint_date"] as? String ?? ""
                let appointTitle = data["appoint_title"] as? String ?? ""
                let appointLocation = data["appoint_location"] as? String ?? ""
                
                return AppointData(appointDate: appointDate, appointTitle: appointTitle, appointLocation: appointLocation, userId: userid)
            }
        }
    }
}
