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
    
    let vaccineType = ["choose vaccine", "Pfizer-BioNTech", "Moderna", "AstraZeneca", "Johnson & Johnson"]
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
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
                
                VStack {
                    // MARK: Single Dose Date
                    DatePicker(selection: $boosterDoseDate, in: ...Date(), displayedComponents: .date) {
                        Text("Pick Date:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 12).bold())
                            .foregroundColor(purple).font(.system(size: 12))
                    }.foregroundColor(purple)
                        .font(.custom("Avenir", size: 12))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(purple.opacity(0.1)).font(.system(size: 12))
                        .cornerRadius(10)
                    
                    // MARK: Single Dose Batch Number
                    SimpleTextField(text: $boosterDosebatchNum, placeholder: Text("Enter batch number"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(purple.opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Booster Dose Vaccination Make
                    HStack {
                        Text("Vaccine Type:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 12).bold())
                            .foregroundColor(purple)
                        
                        Spacer()
                        
                        Picker("Vaccine Type", selection: $boosterDoseVaccType) {
                            ForEach(vaccineType, id: \.self) {
                                Text($0)
                                    .font(.custom("Avenir", size: 12))
                            }
                        }.frame(width: 110)
                    }.padding(.trailing, 50)
                        .foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(purple.opacity(0.1))
                        .cornerRadius(15)
                    
                    // MARK: Single Dose Vaccination Provider
                    SimpleTextField(text: $boosterDoseVaccProvider, placeholder: Text("Enter vaccination provider"))
                        .foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(purple.opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Vaccination Location
                    SimpleTextField(text: $boosterDoseLocation, placeholder: Text("Enter vaccination centre"))
                        .foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(purple.opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Vaccination Country
                    SimpleTextField(text: $boosterDoseCountry, placeholder: Text("Enter country of vaccination"))
                        .foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(purple.opacity(0.1))
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
                            .foregroundColor(Color.white)
                    }).buttonStyle(purpleButton())
                        .padding(.top, 2)
                        .disabled((boosterDosebatchNum != "" && boosterDoseVaccProvider != "" && boosterDoseCountry != "") ? false : true)
                        .opacity((boosterDosebatchNum != "" && boosterDoseVaccProvider != "" && boosterDoseCountry != "") ? 1 : 0.6)
                    
                }.padding(.top, 10)
                
                Spacer()
            }
        }.background(bgWhite())
            .accentColor(purple)
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
