//
//  NewAppointmentView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 04/05/2021.
//

import SwiftUI

struct NewAppointmentView: View {
    @ObservedObject var appointmentData : AppointmentViewModel
    @Environment(\.managedObjectContext) var context
    
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
                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                .padding()
            
            Divider()
                .padding(.horizontal)
            
            HStack {
                Text("Appointment Date:")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                
                Spacer(minLength: 0)
            }
            //            .padding()
            
            HStack {
                Text("Select Date:")
                Spacer()
                
                // MARK: Date Picker
                DatePicker("", selection: $appointmentData.date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            
            // MARK: "Add" button
            
            Button(action: {appointmentData.writeData(context: context)}, label: {
                
                Text("Add Appointment")
                    .font(.body)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            })
            .padding(.vertical)
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 325, minHeight: 0, maxHeight: 40, alignment: .center).padding(.leading,10)
            .background(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
            .cornerRadius(30)
            .padding()
            
            // MARK: button disabled when Text Editor empty
            .disabled(appointmentData.content == "" ? true : false)
            .opacity(appointmentData.content == "" ? 0.5 : 1)
            
        }
        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255).ignoresSafeArea(.all, edges: .bottom))
    }
}

