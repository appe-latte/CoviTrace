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
            Button(action: {},
                   label: {
                    Text("Button")
                   })
                .sheet(isPresented: $appointmentData.newAppointment, content: {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Sheet Content")/*@END_MENU_TOKEN@*/
                })
        }
        
    }
}

struct AppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentView()
    }
}
