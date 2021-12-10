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
    @State var singleDoseDate = Date()
    @State var singleDosebatchNum = ""
    @State var vaccStatus = "Fully Vaccinated"
    @State var singleDoseLocation = ""
    @State var singleDoseVaccProvider = ""
    @State var vaccDoseCountry = ""
    @State var vaccCardVerified = "Not Verified"
    @State var singleDoseUploadDate = Date() // Logs the date the dose is uploaded onto the system.
    
    @ObservedObject private var viewModel = FirstDoseVaccViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Add Single Dose")
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
                    DatePicker(selection: $singleDoseDate, in: ...Date(), displayedComponents: .date) {
                        Text("Pick Date:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(Color(.white)).font(.system(size: 14))
                    }.foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1)).font(.system(size: 12))
                        .font(.custom("Avenir", size: 14))
                        .cornerRadius(10)
                    
                    // MARK: Single Dose Batch Number
                    SimpleTextField(text: $singleDosebatchNum, placeholder: Text("Batch Number"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Single Dose Vaccination Provider
                    SimpleTextField(text: $singleDoseVaccProvider, placeholder: Text("Vaccine Provider"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Vaccination Location
                    SimpleTextField(text: $singleDoseLocation, placeholder: Text("Vaccination Centre"))
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
    
    // MARK: Upload to "Single Dose" DB
    func upload_data(){
        let db = Firestore.firestore()
        let dose4 = dateFormatter.string(from: singleDoseDate)
        db.collection("single_dose").document("Si_D: \(self.authModel.userSession!.uid)").setData(["userId": authModel.userSession!.uid, "single_date": dose4, "single_batch_num": singleDosebatchNum, "single_vacc_type": singleDoseVaccType, "single_provider": singleDoseVaccProvider, "single_issued_by" : singleDoseLocation, "vacc_dose_country": vaccDoseCountry, "vacc_card_verified": vaccCardVerified, "single_dose_upload_date": singleDoseUploadDate], merge: true)
    }
    
    // MARK: update vaccination status
    func update_vacc_status(){
        let db = Firestore.firestore()
        db.collection("first_dose").document("FD: \(self.authModel.userSession!.uid)").setData(["vacc_status": vaccStatus], merge: true)
    }
}
