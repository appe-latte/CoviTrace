//
//  AddSingleDoseView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 14/09/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AddSingleDoseView: View {
    @State var vaccCentre = ""
    @State var vaccTypeFirstDose = ""
    @State var firstDoseDate = Date()
    @State var firstDosebatchNum = ""
    @State var vaccDosageType = "Single"
    @State var vaccStatus = "verification pending"
    @State var firstDosageLocation = ""
    @State var firstDoseVaccProvider = ""
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
                    Text("Log Single Dose")
                        .foregroundColor(.white)
                        .bold()
//                        .font(.system(size: 16))
                }
                .padding(.top, 15)
                
                Divider().background(Color.white)
                
                VStack {
                // MARK: First Dose Date
                DatePicker(selection: $firstDoseDate, in: ...Date(), displayedComponents: .date) {
                    Text("Choose Date:")
                        .padding(.leading)
                        .foregroundColor(Color(.white)).font(.system(size: 14))
                }.foregroundColor(Color(.white))
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                .background(Color(.white).opacity(0.1)).font(.system(size: 12))
                .cornerRadius(10)
                
                // MARK: Firdt Dose Batch Number
                SimpleTextField(text: $firstDosebatchNum, placeholder: Text("Batch Number"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                
                // MARK: Vaccination Location
                SimpleTextField(text: $vaccCentre, placeholder: Text("Test Location"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                
                // MARK: First Dose Vaccination Make
                SimpleTextField(text: $vaccTypeFirstDose, placeholder: Text("Vaccine Make (first)"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
   
                
                // MARK: "Upload" button
                Button(action: {
                    upload_data()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Log Information")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                })
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                .cornerRadius(10)
                .padding(.top, 2)
                
                }.padding(.top, 10)
                Spacer()
            }
        }.navigationTitle("Add Vaccination Information")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Upload to "Vaccinations" DB
    func upload_data(){
        let db = Firestore.firestore()
        let dose1 = dateFormatter.string(from: firstDoseDate)
        db.collection("vaccinations").document().setData(["userId": authModel.userSession!.uid, "vacc_location": vaccCentre,"1st_dose_date": dose1, "1st_dose_batch_num": firstDosebatchNum, "1st_dose_vacc_type": vaccTypeFirstDose, "vacc_status":vaccStatus, "vacc_dosage_type": vaccDosageType])
    }
}

struct AddSingleDoseView_Previews: PreviewProvider {
    static var previews: some View {
        AddSingleDoseView()
    }
}
