//
//  AddSecondDoseView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 14/09/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AddSecondDoseView: View {
    @State var secondDoseVaccType = ""
    @State var secondDoseDate = Date()
    @State var secondDosebatchNum = ""
    @State var shotType = "Second Dose"
    @State var vaccStatus = "Fully Vaccinated"
    @State var secondDosageLocation = ""
    @State var secondDoseVaccProvider = ""
    @State var secondVaccDoseCountry = ""
    @State var vaccCardVerified = "Not Verified"
    @State var secondDoseUploadDate = Date() // Logs the date the second dose is uploaded onto the system.
    
    @ObservedObject private var viewModel = SecondDoseVaccViewModel()
    @ObservedObject private var authModel = AuthViewModel()
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
                    Text("Add Second Dose")
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
                    // MARK: Second Dose Date
                    DatePicker(selection: $secondDoseDate, in: ...Date(), displayedComponents: .date) {
                        Text("Pick Date:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 12).bold())
                            .foregroundColor(purple).font(.system(size: 14))
                    }.foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(purple.opacity(0.1)).font(.system(size: 12))
                        .cornerRadius(10)
                        .font(.custom("Avenir", size: 12))
                    
                    // MARK: Second Dose Batch Number
                    SimpleTextField(text: $secondDosebatchNum, placeholder: Text("Enter batch number"))
                        .foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(purple.opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Second Dose Vaccination Make
                    HStack {
                        Text("Vaccine Type:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 12).bold())
                            .foregroundColor(purple)
                        
                        Spacer()
                        
                        Picker("Vaccine Type", selection: $secondDoseVaccType) {
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
                    
                    // MARK: Second Dose Vaccination Provider
                    SimpleTextField(text: $secondDoseVaccProvider, placeholder: Text("Enter vaccination provider"))
                        .foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(purple.opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Second Dose Vaccination Location
                    SimpleTextField(text: $secondDosageLocation, placeholder: Text("Enter vaccination centre"))
                        .foregroundColor(purple)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(purple.opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Second Dose Vaccination Country
                    SimpleTextField(text: $secondVaccDoseCountry, placeholder: Text("Enter country of vaccination"))
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
                        .disabled((secondDosebatchNum != "" && secondDoseVaccProvider != "" && secondVaccDoseCountry != "") ? false : true)
                        .opacity((secondDosebatchNum != "" && secondDoseVaccProvider != "" && secondVaccDoseCountry != "") ? 1 : 0.6)
                }.padding(.top, 10)
                
                Spacer()
            }
        }.background(bgWhite())
            .accentColor(purple)
    }
    
    func upload_data(){
        let db = Firestore.firestore()
        let dose2 = dateFormatter.string(from: secondDoseDate)
        db.collection("second_dose").document("SD: \(self.authModel.userSession!.uid)").setData(["userId": authModel.userSession!.uid, "2nd_dose_date": dose2, "2nd_dose_batch_num": secondDosebatchNum, "2nd_dose_vacc_type": secondDoseVaccType, "2nd_provider" : secondDoseVaccProvider, "2nd_issued_by" : secondDosageLocation, "2nd_vacc_dose_country": secondVaccDoseCountry, "vacc_card_verified": vaccCardVerified, "2nd_dose_upload_date" : secondDoseUploadDate], merge: true)
    }
    
    func update_vacc_status() {
        let db = Firestore.firestore()
        // MARK: Update vacc_status to reflect in VaccPassView
        db.collection("first_dose").document("FD: \(self.authModel.userSession!.uid)").setData(["vacc_status": vaccStatus], merge: true)
    }
}
