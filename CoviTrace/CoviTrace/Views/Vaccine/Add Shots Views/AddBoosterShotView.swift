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
    
    let vaccineType = ["Select Vaccine", "Pfizer-BioNTech", "Moderna", "AstraZeneca", "Johnson & Johnson", "Sinovac", "Novavax"]
    
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
                        .foregroundColor(purple)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("close-p")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }).padding(5)
                        .clipShape(Circle())
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                
                VStack(spacing: 10) {
                    
                    // MARK: Booster Vaccination Make
                    HStack {
                        Text("Vaccine Type:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(purple)
                        
                        Spacer()
                        
                        Picker("Vaccine Type", selection: $boosterDoseVaccType) {
                            ForEach(vaccineType, id: \.self) {
                                Text($0)
                                    .font(.custom("Avenir", size: 12))
                            }
                        }.frame(width: 110)
                    }.padding(.trailing, 10)
                        .foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    
                    // MARK: Booster Dose Date
                    HStack {
                        Text("Pick Date:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(purple).font(.system(size: 12))
                        DatePicker(selection: $boosterDoseDate, in: ...Date(), displayedComponents: .date) {}
                    }.foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .font(.system(size: 12))
                        .font(.custom("Avenir", size: 12))
                    
                    // MARK: Booster Dose Batch Number
                    SimpleTextField(text: $boosterDosebatchNum, placeholder: Text("Enter batch number"))
                        .font(.custom("Avenir", size: 12))
                        .foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    
                    // MARK: Booster Dose Vaccination Provider
                    SimpleTextField(text: $boosterDoseVaccProvider, placeholder: Text("Enter vaccination provider"))
                        .foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    
                    // MARK: Booster Vaccination Location
                    SimpleTextField(text: $boosterDoseLocation, placeholder: Text("Enter vaccination centre"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    
                    // MARK: Booster Vaccination Country
                    SimpleTextField(text: $boosterDoseCountry, placeholder: Text("Enter country of vaccination"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    
                    // MARK: "Submit" button
                    Button(action: {
                        upload_data()
                        update_vacc_status()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Submit")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }).buttonStyle(purpleButton())
                        .padding(.top, 2)
                        .disabled((boosterDosebatchNum != "" && boosterDoseVaccProvider != "" && boosterDoseCountry != "") ? false : true)
                        .opacity((boosterDosebatchNum != "" && boosterDoseVaccProvider != "" && boosterDoseCountry != "") ? 1 : 0.6)
                }.padding(.top, 10)
                
                Spacer()
            }
        }.background(bgWhite())
            .accentColor(green)
    }
    
    func upload_data(){
        let db = Firestore.firestore()
        let dose3 = dateFormatter.string(from: boosterDoseDate)
        db.collection("booster").document("BD: \(self.authModel.userSession!.uid)").setData(["userId": authModel.userSession!.uid, "booster_date": dose3, "booster_batch_num": boosterDosebatchNum, "booster_vacc_type": boosterDoseVaccType, "booster_provider" : boosterDoseVaccProvider, "booster_issued_by" : boosterDoseLocation, "booster_dose_country": boosterDoseCountry, "booster_upload_date": boosterDoseUploadDate, "vacc_card_verified": vaccCardVerified], merge: true)
    }
    
    func update_vacc_status(){
        let db = Firestore.firestore()
        db.collection("first_dose").document("FD: \(self.authModel.userSession!.uid)").setData(["vacc_status": vaccStatus], merge: true)
    }
}
