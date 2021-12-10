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
    @State var boosterDoseLocation = ""
    @State var boosterDoseVaccProvider = ""
    @State var boosterDoseCountry = ""
    @State var vaccCardVerified = "Not Verified"
    @State var vaccStatus = "Fully Vaccinated"
    @State var boosterDoseUploadDate = Date() // Logs the date the dose is uploaded onto the system.
    
    @ObservedObject private var viewModel = FirstDoseVaccViewModel()
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
        ZStack {
            VStack {
                HStack {
                    Text("Add Booster Dose")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("close")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }).padding(5)
                        .clipShape(Circle())
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                
                VStack {
                    // MARK: Single Dose Date
                    DatePicker(selection: $boosterDoseDate, in: ...Date(), displayedComponents: .date) {
                        Text("Pick Date:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(Color(.white)).font(.system(size: 14))
                    }.foregroundColor(Color(.white))
                        .font(.custom("Avenir", size: 14))
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
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(Color(.white))
                        
                        Spacer()
                        
                        Picker("Vaccine Type", selection: $boosterDoseVaccType) {
                            ForEach(vaccineType, id: \.self) {
                                Text($0)
                                    .font(.custom("Avenir", size: 14))
                            }
                        }.frame(width: 110)
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
                    
                    // MARK: "Submit" button
                    Button(action: {
                        upload_data()
                        update_vacc_status()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Submit")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }).frame(width: 150, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.top, 2)
                    
                }.padding(.top, 10)
                
                Spacer()
            }
        }.background(bgGrad())
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(Color.white)
    }
    
    // MARK: Upload to "booster" DB
    func upload_data(){
        let db = Firestore.firestore()
        let dose3 = dateFormatter.string(from: boosterDoseDate)
        db.collection("booster").document("BD: \(self.authModel.userSession!.uid)").setData(["userId": authModel.userSession!.uid, "booster_date": dose3, "booster_batch_num": boosterDosebatchNum, "booster_vacc_type": boosterDoseVaccType, "booster_provider" : boosterDoseVaccProvider, "booster_issued_by" : boosterDoseLocation, "booster_dose_country": boosterDoseCountry, "booster_upload_date": boosterDoseUploadDate, "vacc_card_verified": vaccCardVerified], merge: true)
    }
    
    // MARK: updates the Vaccination Status
    func update_vacc_status(){
        let db = Firestore.firestore()
        db.collection("first_dose").document("FD: \(self.authModel.userSession!.uid)").setData(["vacc_status": vaccStatus], merge: true)
    }
}
