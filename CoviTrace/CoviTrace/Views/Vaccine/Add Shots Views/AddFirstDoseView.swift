//
//  AddFirstDoseView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 14/09/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AddFirstDoseView: View {
    @State var firstDoseVaccType = ""
    @State var firstDoseDate = Date()
    @State var firstDosebatchNum = ""
    @State var vaccStatus = "Partially Vaccinated"
    @State var firstDosageLocation = ""
    @State var firstDoseVaccProvider = ""
    @State var firstVaccDoseCountry = ""
    @State var firstDoseUploadDate = Date() // Logs the date the first dose is uploaded onto the system.
    @State var vaccCardVerified = "Not Verified"
    @State var documentId = ""
    
    // MARK: Objects
    @ObservedObject private var viewModel = FirstDoseVaccViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let vaccineType = ["Select Vaccine", "Pfizer-BioNTech", "Moderna", "AstraZeneca", "Johnson & Johnson", "Sinovac", "Novavax"]
    
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
                    Text("Add First Dose")
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
                    
                    // MARK: First Dose Vaccination Make
                    HStack {
                        Text("Vaccine Type:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(purple)
                        
                        Spacer()
                        
                        Picker("Vaccine Type", selection: $firstDoseVaccType) {
                            ForEach(vaccineType, id: \.self) {
                                Text($0)
                                    .font(.custom("Avenir", size: 12))
                            }
                        }.frame(width: 110)
                    }.padding(.trailing, 10)
                        .foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    
                    // MARK: First Dose Date
                    HStack {
                        Text("Pick Date:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(purple).font(.system(size: 12))
                        DatePicker(selection: $firstDoseDate, in: ...Date(), displayedComponents: .date) {}
                    }.foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .font(.system(size: 12))
                        .font(.custom("Avenir", size: 12))
                    
                    // MARK: First Dose Batch Number
                    SimpleTextField(text: $firstDosebatchNum, placeholder: Text("Enter batch number"))
                        .font(.custom("Avenir", size: 12))
                        .foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    
                    // MARK: First Dose Vaccination Provider
                    SimpleTextField(text: $firstDoseVaccProvider, placeholder: Text("Enter vaccination provider"))
                        .foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    
                    // MARK: Vaccination Location
                    SimpleTextField(text: $firstDosageLocation, placeholder: Text("Enter vaccination centre"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    
                    // MARK: Vaccination Country
                    SimpleTextField(text: $firstVaccDoseCountry, placeholder: Text("Enter country of vaccination"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    
                    // MARK: "Submit" button
                    if !firstDosebatchNum.isEmpty && !firstDoseVaccProvider.isEmpty && !firstVaccDoseCountry.isEmpty {
                    Button(action: {
                        upload_data()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Submit")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }).buttonStyle(purpleButton())
                        .padding(.top, 2)
                        .disabled(false)
                    } else {
                        Button(action: {
                            upload_data()
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Submit")
                                .font(.custom("Avenir", size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                        }).buttonStyle(purpleButton())
                            .padding(.top, 2)
                            .disabled(true)
                            .opacity(0.6)
                    }
                }.padding(.top, 10)
                
                Spacer()
            }
        }.background(bgWhite())
            .accentColor(green)
    }
    
    func upload_data(){
        let db = Firestore.firestore()
        let dose1 = dateFormatter.string(from: firstDoseDate)
        db.collection("first_dose").document("FD: \(self.authModel.userSession!.uid)").setData(["userId": authModel.userSession!.uid, "1st_dose_date": dose1, "1st_dose_batch_num": firstDosebatchNum, "1st_dose_vacc_type": firstDoseVaccType, "1st_provider" : firstDoseVaccProvider, "1st_issued_by" : firstDosageLocation, "1st_vacc_dose_country": firstVaccDoseCountry, "vacc_card_verified": vaccCardVerified, "1st_dose_upload_date": firstDoseUploadDate, "vacc_status": vaccStatus], merge: true)
    }
}
