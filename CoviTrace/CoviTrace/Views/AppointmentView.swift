//
//  AppointmentView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 04/05/2021.
//

import SwiftUI

struct AppointmentView: View {
    @StateObject var appointmentData = AppointmentViewModel()
    
    var body: some View {
        ZStack {
            Background()
            Button(action: {appointmentData.newAppointment.toggle()},
                   label: {
                    Text("New Appointment")
                   })
                .sheet(isPresented: $appointmentData.newAppointment, content: {
                    
                    NewAppointmentView(appointmentData: appointmentData)
                })
        }
        
    }
}
