//
//  AppointmentView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 04/05/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AppointmentView: View {
    @State private var appointDate = ""
    @State private var appointTitle = ""
    @State private var appointLocation = ""
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var viewModel = AppointmentViewModel()
    @State var showSheetView = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter
    }
    
    var body: some View {
        ZStack
        {
            VStack {
                VStack{
                    
                    // MARK: "Add Appointment" Button
                    Button(action: {
                        self.showSheetView.toggle()
                    }, label: {
                        Text("Add Appointment")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(12)
                    .padding()
                    .sheet(isPresented: $showSheetView) {
                        NewAppointmentView()
                    }
                }
                .padding(5.0)
                .background(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                
                // MARK: Test Result Information
                
                VStack {
                    HStack{
                        Text("Appointments")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                            .padding(5)
                        
                        Spacer()
                    }
                    Divider()
                    List(viewModel.appointments) { appointments in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(appointments.appointDate)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                Spacer()
                                Text(appointments.appointTitle)
                                    .font(.subheadline)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .fontWeight(.semibold)
                            }
                            Text(appointments.appointLocation)
                                .font(.subheadline)
                        }
                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                    .onAppear() {
                        self.viewModel.fetchData(id: authModel.userSession!.uid)
                    }
                }
                
                //            }
            }.navigationBarTitle("Appointments", displayMode: .inline)
        }
    }
}
