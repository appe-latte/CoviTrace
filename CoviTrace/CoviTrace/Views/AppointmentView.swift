//
//  AppointmentView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 04/05/2021.
//

import SwiftUI
import CoreData

struct AppointmentView: View {
    @StateObject var appointmentData = AppointmentViewModel()
    
    // MARK: Fetching Appointment Data
    @FetchRequest(entity: Appointment.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation: .spring()) var results : FetchedResults<Appointment>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        ZStack {
            Background()
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
                VStack(spacing: 0) {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        LazyVStack(alignment: .leading, spacing: 20){
                            ForEach(results) { task in
                                VStack(alignment: .leading, spacing: 5, content: {
                                    Text(task.content ?? "")
                                        .font(.body)
                                        .fontWeight(.bold)
                                    
                                    Text(task.date ?? Date(), style: .date)
                                        .fontWeight(.semibold)
                                        .font(.body)
                                })
                                .foregroundColor(.white)
                                .contextMenu {
                                    // MARK: Delete "appointment"
                                    Button(action: {
                                        context.delete(task)
                                        try! context.save()
                                    }, label: {
                                        Text("Delete Appointment")
                                    })
                                }
                            }
                        }
                    })
                    .padding()
                }
                
                Button(action: {appointmentData.newAppointment.toggle()}, label: {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .clipShape(Circle())
                })
                .padding()
                
            })
            .sheet(isPresented: $appointmentData.newAppointment, content: {
                
                NewAppointmentView(appointmentData: appointmentData)
            })
        }.navigationBarTitle("Appointments", displayMode: .inline)
        
    }
}
