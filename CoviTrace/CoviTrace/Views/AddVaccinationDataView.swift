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
            Background()
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
                    Text("Choose Date:")
                        .padding(.leading)
                        .foregroundColor(Color(.white)).font(.system(size: 14))
                }.foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                .background(Color(.white).opacity(0.1)).font(.system(size: 12))
                .cornerRadius(15)
                
                // MARK: Firdt Dose Batch Number
                SimpleTextField(text: $firstDosebatchNum, placeholder: Text("Batch Number (first)"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                
                // MARK: Vaccination Location
                SimpleTextField(text: $vaccCentre, placeholder: Text("Test Location"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                
                // MARK: First Dose Vaccination Make
                SimpleTextField(text: $vaccTypeFirstDose, placeholder: Text("Vaccine Make (first)"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                
                // MARK: Second Dose Date
                DatePicker(selection: $secondDoseDate, in: ...Date(), displayedComponents: .date) {
                    Text("Choose Date:")
                        .padding(.leading)
                        .foregroundColor(Color(.white)).font(.system(size: 12))
                }.foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                .background(Color(.white).opacity(0.1)).font(.system(size: 14))
                .cornerRadius(15)
                
                // MARK: Second Dose Batch Number
                SimpleTextField(text: $secondDosebatchNum, placeholder: Text("Batch Number (second)"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                
                // MARK: Second Dose Vaccination Make
                SimpleTextField(text: $vaccTypeSecondDose, placeholder: Text("Vaccine Make (second)"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 325, minHeight: 0, maxHeight: 40).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                
                // MARK: "Upload" button
                Button(action: {
                    upload_data()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Upload Information")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                })
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                .cornerRadius(15)
                .padding(.top, 2)
                
                Spacer()
            }
        }.navigationTitle("Add Vaccination Information")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Upload to "Vaccinations" DB
    func upload_data(){
        let db = Firestore.firestore()
        let dose1 = dateFormatter.string(from: firstDoseDate)
        let dose2 = dateFormatter.string(from: secondDoseDate)
        db.collection("vaccinations").document().setData(["userId": authModel.userSession!.uid, "vacc_location": vaccCentre,"1st_dose_date": dose1, "1st_dose_batch_num": firstDosebatchNum, "1st_dose_vacc_type": vaccTypeFirstDose, "2nd_dose_date":dose2, "2nd_dose_batch_num":secondDosebatchNum, "2nd_dose_vacc_type":vaccTypeSecondDose,
                                                          "vacc_status":vaccStatus])
    }
}

struct AddVaccinationDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddVaccinationDataView()
    }
}
