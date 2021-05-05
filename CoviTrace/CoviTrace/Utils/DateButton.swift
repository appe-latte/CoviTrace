//
//  DateButton.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 05/05/2021.
//

import SwiftUI

struct DateButton: View {
    var title : String
    @ObservedObject var appointmentData : AppointmentViewModel
    
    var body: some View {
        Button(action: {appointmentData.updateDate(value: title)}, label: {
            
            Text(title)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
//                .foregroundColor(appointmentData.checkDate() == title ? .white : .gray)
                .background(Color(.white))
                .cornerRadius(5)
        })
    }
}
