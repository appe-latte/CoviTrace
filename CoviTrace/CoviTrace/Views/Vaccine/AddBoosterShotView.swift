//
//  BoosterShotView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/10/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AddBoosterShotView: View {
    @State var boosterDoseVaccType = ""
    @State var boosterDoseDate = Date()
    @State var boosterDosebatchNum = ""
    @State var shotType = "Booster"
    @State var boosterDoseLocation = ""
    @State var boosterDoseVaccProvider = ""
    @State var boosterDoseCountry = ""
    @State var boosterDoseUploadDate = Date() // Logs the date the dose is uploaded onto the system.
    
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var boosterModel = BoosterShotViewModel()
    @Environment(\.presentationMode) var presentationMode

    let vaccineType = ["Pfizer-BioNTech", "Moderna", "AstraZeneca", "Johnson & Johnson"] // Picker data for vaccine make
    
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
                    Text("Add Booster Information")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .padding(.top, 15)
                
                VStack {
                    // MARK: Single Dose Date
                    DatePicker(selection: $boosterDoseDate, in: ...Date(), displayedComponents: .date) {
                        Text("Choose Date:")
                            .padding(.leading)
                            .foregroundColor(Color(.white)).font(.system(size: 14))
                    }.foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1)).font(.system(size: 12))
                        .cornerRadius(10)
                    
                    // MARK: Single Dose Batch Number
                    SimpleTextField(text: $boosterDosebatchNum, placeholder: Text("Batch Number"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Booster Dose Vaccination Make
                    HStack {
                        Text("Vaccine Type:")
                            .padding(.leading)
                            .foregroundColor(Color(.white)).font(.system(size: 14))
                        
                        Spacer()
                        
                        Picker("Vaccine Type", selection: $boosterDoseVaccType) {
                            ForEach(vaccineType, id: \.self) {
                                Text($0)
                            }
                        }
                    }.padding(.trailing, 50)
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(15)
                    
                    // MARK: Single Dose Vaccination Provider
                    SimpleTextField(text: $boosterDoseVaccProvider, placeholder: Text("Vaccine Provider"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Vaccination Location
                    SimpleTextField(text: $boosterDoseLocation, placeholder: Text("Vaccination Centre"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Vaccination Country
                    SimpleTextField(text: $boosterDoseCountry, placeholder: Text("Vaccination Country"))
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
    
    // MARK: Upload to "booster" DB
    
    func upload_data(){
        let db = Firestore.firestore()
        let dose3 = dateFormatter.string(from: boosterDoseDate)
        db.collection("booster").document().setData(["userId": authModel.userSession!.uid, "booster_date": dose3, "booster_batch_num": boosterDosebatchNum, "booster_vacc_type": boosterDoseVaccType, "booster_provider" : boosterDoseVaccProvider, "booster_issued_by" : boosterDoseLocation, "booster_dose_country": boosterDoseCountry, "booster_upload_date": boosterDoseUploadDate, "shot_type": shotType])
    }
}