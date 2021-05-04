//
//  NewAppointmentView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 04/05/2021.
//

import SwiftUI

struct NewAppointmentView: View {
    @ObservedObject var appointmentData : AppointmentViewModel
    
    var body: some View {
        VStack {
//            Background()
            
            HStack {
                
                Text("Add New Appointment")
                    .font(.body)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            
            // MARK: Appointment text entry
            TextEditor(text: $appointmentData.content)
                .foregroundColor(.white)
                .cornerRadius(15)
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                Text("Date")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer(minLength: 0)
            }
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        }
        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
    }
}

