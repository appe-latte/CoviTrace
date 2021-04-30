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
    @State private var batchNum = ""
    @State private var vaccDate = Date()
    @State private var vaccCentre = ""
    @State private var vaccType = ""
    @State private var firstDosageDate = Date()
    @State private var secondDosageDate = Date()
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        ZStack{
            Background()
            VStack{
                // MARK: Batch Number
                SimpleTextField(text: $batchNum, placeholder: Text("Enter Batch number"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Vaccination Location
                SimpleTextField(text: $vaccCentre, placeholder: Text("Enter Test Location"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Vaccination Date
                DatePicker(selection: $vaccDate, in: ...Date(), displayedComponents: .date) {
                    Text("Vaccination Date")
                        .padding(.leading, 15)
                }
                .foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                .background(Color(.white).opacity(0.1))
                .cornerRadius(15)
                .font(.footnote)
                
                // MARK: Vaccination Make
                SimpleTextField(text: $vaccType, placeholder: Text("Enter Vaccine Type"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: First Dose Date
                DatePicker(selection: $firstDosageDate, in: ...Date(), displayedComponents: .date) {
                    Text("First Dosage Date")
                        .padding(.leading, 15)
                }
                .foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                .background(Color(.white).opacity(0.1))
                .cornerRadius(15)
                .font(.footnote)
                
                // MARK: Second Dose Date
                DatePicker(selection: $secondDosageDate, in: ...Date(), displayedComponents: .date) {
                    Text("Second Dosage Date")
                        .padding(.leading, 15)
                }
                .foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                .background(Color(.white).opacity(0.1))
                .cornerRadius(15)
                .font(.footnote)
                
                // MARK: "Upload" button
                Button(action: {
                    upload_data()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Upload")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading,10)
                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                .cornerRadius(30)
                .padding(.top, 2)
                
                //                Spacer()
            }
        }.navigationBarHidden(false)
    }
    
    // MARK: Upload to "Vaccinations" DB
    func upload_data(){
        let db = Firestore.firestore()
        db.collection("vaccinations").document().setData(["userId": authModel.userSession!.uid, "vacc_batch_num": batchNum, "vaccination_date": vaccDate, "vaccine_centre": vaccCentre, "vaccine_type": vaccType, "first_dosage": firstDosageDate, "second_dosage": secondDosageDate])
    }
}

struct AddVaccinationDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddVaccinationDataView()
    }
}
