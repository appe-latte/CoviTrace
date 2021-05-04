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
            Background()
            
            HStack {
                
                Text("Add New Appointment")
                    .font(.body)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            TextEditor(text: $appointmentData.content)
                .padding()
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                Text("When")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        }
    }
}

