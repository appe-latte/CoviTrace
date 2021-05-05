//
//  AppointmentViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 04/05/2021.
//

import SwiftUI
import CoreData

class AppointmentViewModel : ObservableObject {
    @Published var content = ""
    @Published var date = Date()
    @Published var newAppointment = false
    @Published var updateItem : Appointment!
    
    let calendar = Calendar.current
    
    //    func checkDate() -> String {
    //        return "Date"
    //    }
    
    func updateDate(value: String) {
        if value == "Date"
        {
            
        }
    }
    
    func writeData(context: NSManagedObjectContext) {
        
        let newAppt = Appointment(context: context)
        newAppt.date = date
        newAppt.content = content
        
        // MARK: Save the data
        
        do {
            try context.save()
            newAppointment.toggle()
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    
    func EditItem(item: Appointment){
        updateItem = item
        date = item.date!
        content = item.content!
        newAppointment.toggle()
    }
}
