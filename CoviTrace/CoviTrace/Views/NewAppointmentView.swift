//
//  NewAppointmentView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 04/05/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct NewAppointmentView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var authModel = AuthViewModel()
    @State private var appointDate = Date()
    @State private var appointTitle = ""
    @State private var appointLocation = ""
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter
    }
    
    var body: some View {
        
        ZStack{
            bgGreen()
            VStack{
                
                Text("Add Appointments")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                // MARK: Appointment Date
                DatePicker(selection: $appointDate, in: Date()..., displayedComponents: .date) {
                    Text("Choose Date:")
                        .padding(.leading)
                        .foregroundColor(Color(.white)).font(.system(size: 14))
                }.foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                .background(Color(.white).opacity(0.1)).font(.system(size: 14))
                .cornerRadius(15)
                
                // MARK: Appointment Title
                SimpleTextField(text: $appointTitle, placeholder: Text("Appointment Title"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Appointment Location
                SimpleTextField(text: $appointLocation, placeholder: Text("Appointment Location"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: "Log Results" Button
                Button(action: {
                    upload_data()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Text("SUBMIT")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading,10)
                .background(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                .cornerRadius(15)
                .padding(.top, 2)
                
                Spacer()
            }
            .padding(.top, 15)
        }.navigationBarHidden(false)
    }
    
    // MARK: Upload to "Appointment" DB
    func upload_data(){
        let db = Firestore.firestore()
        let date = dateFormatter.string(from: appointDate)
        db.collection("appointments").document().setData(["userId": authModel.userSession!.uid, "appoint_date" : date, "appoint_title" : appointTitle, "appoint_location": appointLocation])
    }
}

