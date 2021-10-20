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
    @State var singleDoseVaccType = "Johnson & Johnson"
    @State var firstDoseDate = Date()
    @State var firstDosebatchNum = ""
    @State var shotType = "Single"
    @State var vaccStatus = "Fully Vaccinated"
    @State var firstDosageLocation = ""
    @State var firstDoseVaccProvider = ""
    @State var vaccDoseCountry = ""
    @State var vaccCardVerified = "verification pending"
    @State var singleDoseUploadDate = Date() // Logs the date the dose is uploaded onto the system.
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
                    Text("Add Single Dosage Information")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .padding(.top, 15)                
                
                VStack {
                    // MARK: Single Dose Date
                    DatePicker(selection: $firstDoseDate, in: ...Date(), displayedComponents: .date) {
                        Text("Choose Date:")
                            .padding(.leading)
                            .foregroundColor(Color(.white)).font(.system(size: 14))
                    }.foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1)).font(.system(size: 12))
                        .cornerRadius(10)
                    
                    // MARK: Single Dose Batch Number
                    SimpleTextField(text: $firstDosebatchNum, placeholder: Text("Batch Number"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)

                    // MARK: Single Dose Vaccination Provider
                    SimpleTextField(text: $firstDoseVaccProvider, placeholder: Text("Vaccine Provider"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Vaccination Location
                    SimpleTextField(text: $firstDosageLocation, placeholder: Text("Vaccination Centre"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Vaccination Country
                    SimpleTextField(text: $vaccDoseCountry, placeholder: Text("Vaccination Country"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Upload Vaccine Card
                    Button(action: {
                        // add code to upload certificate
                    }, label: {
                            Text("Upload Vaccine Card")
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .fontWeight(.semibold)
                                .padding(.trailing, 10)
                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.top, 2)
                    
                    // MARK: "Submit" button
                    Button(action: {
                        upload_data()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("SUBMIT")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    })
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                        .padding(.top, 2)
                    
                }.padding(.top, 10)
                Spacer()
            }
        }.navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Upload to "Vaccinations" DB
    
    func upload_data(){
        let db = Firestore.firestore()
        let dose1 = dateFormatter.string(from: firstDoseDate)
        db.collection("vaccinations").document().setData(["userId": authModel.userSession!.uid, "1st_dose_date": dose1, "1st_dose_batch_num": firstDosebatchNum, "shot_type": shotType, "1st_provider" : firstDoseVaccProvider, "1st_issued_by" : firstDosageLocation, "vacc_dose_country": vaccDoseCountry, "vacc_card_verified": vaccCardVerified, "single_dose_upload_date": singleDoseUploadDate])
    }
}

struct AddSingleDoseView_Previews: PreviewProvider {
    static var previews: some View {
        AddSingleDoseView()
    }
}
