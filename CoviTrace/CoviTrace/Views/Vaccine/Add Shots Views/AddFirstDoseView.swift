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
    @State var vaccStatus = "First Dose Administered"
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
    
    let vaccineType = ["Pfizer-BioNTech", "Moderna", "AstraZeneca", "Johnson & Johnson"]
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Add First Dose")
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
                    // MARK: First Dose Date
                    DatePicker(selection: $firstDoseDate, in: ...Date(), displayedComponents: .date) {
                        Text("Pick Date:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(Color(.white)).font(.system(size: 14))
                    }.foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1)).font(.system(size: 12))
                        .font(.custom("Avenir", size: 14))
                        .cornerRadius(10)
                    
                    // MARK: First Dose Batch Number
                    SimpleTextField(text: $firstDosebatchNum, placeholder: Text("Batch Number"))
                        .font(.custom("Avenir", size: 14))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: First Dose Vaccination Make
                    HStack {
                        Text("Vaccine Type:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(Color(.white))
                        
                        Spacer()
                        
                        Picker("Vaccine Type", selection: $firstDoseVaccType) {
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
                    SimpleTextField(text: $firstVaccDoseCountry, placeholder: Text("Vaccination Country"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: "Submit" button
                    Button(action: {
                        upload_data()
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
                        .disabled((firstDosebatchNum != "" && firstDoseVaccProvider != "" && firstVaccDoseCountry != "") ? false : true)
                        .opacity((firstDosebatchNum != "" && firstDoseVaccProvider != "" && firstVaccDoseCountry != "") ? 1 : 0.6)
                }.padding(.top, 10)
                
                Spacer()
            }
        }.background(bgGrad())
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(Color.white)
    }
    
    // MARK: Upload to "Vaccinations" DB
    func upload_data(){
        let db = Firestore.firestore()
        let dose1 = dateFormatter.string(from: firstDoseDate)
        db.collection("first_dose").document("FD: \(self.authModel.userSession!.uid)").setData(["userId": authModel.userSession!.uid, "1st_dose_date": dose1, "1st_dose_batch_num": firstDosebatchNum, "1st_dose_vacc_type": firstDoseVaccType, "1st_provider" : firstDoseVaccProvider, "1st_issued_by" : firstDosageLocation, "1st_vacc_dose_country": firstVaccDoseCountry, "vacc_card_verified": vaccCardVerified, "1st_dose_upload_date": firstDoseUploadDate, "vacc_status": vaccStatus], merge: true)
    }
}

