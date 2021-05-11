//
//  AddVaccinationDataView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/03/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AddVaccinationDataView: View {
    @State private var vaccCentre = ""
    @State private var vaccTypeFirstDose = ""
    @State private var vaccTypeSecondDose = ""
    @State private var firstDoseDate = Date()
    @State private var firstDosebatchNum = ""
    @State private var secondDoseDate = Date()
    @State private var secondDosebatchNum = ""
    @State private var vaccStatus = "verification pending"
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        ZStack{
            bgGreen()
            
            
            VStack {
                VStack{
                    Text("Add Vaccination Data")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.top, 15)
                
                // MARK: First Dose Date
                DatePicker(selection: $firstDoseDate, in: ...Date(), displayedComponents: .date) {
                    Text("First Dose Date")
                        .padding(.leading, 15)
                        .foregroundColor(.white)
                }
                .foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                .background(Color(.white).opacity(0.1))
                .cornerRadius(10)
                .font(.footnote)
                
                // MARK: Firdt Dose Batch Number
                SimpleTextField(text: $firstDosebatchNum, placeholder: Text("Enter 1st dose batch no."))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                
                // MARK: Vaccination Location
                SimpleTextField(text: $vaccCentre, placeholder: Text("Enter test location"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                
                // MARK: First Dose Vaccination Make
                SimpleTextField(text: $vaccTypeFirstDose, placeholder: Text("Enter first vaccine dose make"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                
                // MARK: Second Dose Date
                DatePicker(selection: $secondDoseDate, in: ...Date(), displayedComponents: .date) {
                    Text("Select second dose date")
                        .padding(.leading, 15)
                }
                .foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                .background(Color(.white).opacity(0.1))
                .cornerRadius(10)
                .font(.footnote)
                
                // MARK: Second Dose Batch Number
                SimpleTextField(text: $secondDosebatchNum, placeholder: Text("Enter second dose batch no."))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                
                // MARK: Second Dose Vaccination Make
                SimpleTextField(text: $vaccTypeSecondDose, placeholder: Text("Enter second vaccine dose make"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                
                // MARK: "Upload" button
                Button(action: {
                    upload_data()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Image("upload")
                            .resizable()
                            .frame(width: 30, height: 25)
                            .scaledToFit()
                        Text("Upload")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    
                })
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading,10)
                .background(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                .cornerRadius(30)
                .padding(.top, 2)
                
                Spacer()
            }
        }.navigationTitle("Add Vaccination Information")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Upload to "Vaccinations" DB
    func upload_data(){
        let db = Firestore.firestore()
        db.collection("vaccinations").document().setData(["userId": authModel.userSession!.uid, "vacc_location": vaccCentre,"1st_dose_date": firstDoseDate, "1st_dose_batch_num": firstDosebatchNum, "1st_dose_vacc_type": vaccTypeFirstDose, "2nd_dose_date":secondDoseDate, "2nd_dose_batch_num":secondDosebatchNum, "2nd_dose_vacc_type":vaccTypeSecondDose,
            "vacc_status":vaccStatus])
    }
}

struct AddVaccinationDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddVaccinationDataView()
    }
}
