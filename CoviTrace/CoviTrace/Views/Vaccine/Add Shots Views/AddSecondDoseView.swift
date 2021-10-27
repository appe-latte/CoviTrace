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
    @State var secondDoseCountry = ""
    @State var vaccCardVerified = "Verification Pending"
    @State var secondDoseUploadDate = Date() // Logs the date the second dose is uploaded onto the system.
    
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    let vaccineType = ["Pfizer-BioNTech", "Moderna", "AstraZeneca", "Johnson & Johnson"]
    
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
                    Text("Add Second Dosage Information")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .padding(.top, 15)
                
                VStack {
                    // MARK: Second Dose Date
                    DatePicker(selection: $secondDoseDate, in: ...Date(), displayedComponents: .date) {
                        Text("Choose Date:")
                            .padding(.leading)
                            .foregroundColor(Color(.white)).font(.system(size: 14))
                    }.foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1)).font(.system(size: 12))
                        .cornerRadius(10)
                    
                    // MARK: Second Dose Batch Number
                    SimpleTextField(text: $secondDosebatchNum, placeholder: Text("Batch Number"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Second Dose Vaccination Make
                    HStack {
                        Text("Vaccine Type:")
                            .padding(.leading)
                            .foregroundColor(Color(.white)).font(.system(size: 14))
                        
                        Spacer()
                        
                        Picker("Vaccine Type", selection: $secondDoseVaccType) {
                            ForEach(vaccineType, id: \.self) {
                                Text($0)
                            }
                        }
                    }.padding(.trailing, 50)
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(15)
                    
                    // MARK: Second Dose Vaccination Provider
                    SimpleTextField(text: $secondDoseVaccProvider, placeholder: Text("Vaccine Provider"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Second Dose Vaccination Location
                    SimpleTextField(text: $secondDosageLocation, placeholder: Text("Vaccination Centre"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: Second Dose Vaccination Country
                    SimpleTextField(text: $secondDoseCountry, placeholder: Text("Vaccination Country"))
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
        let dose2 = dateFormatter.string(from: secondDoseDate)
        db.collection("vaccinations").document().setData(["userId": authModel.userSession!.uid, "2nd_dose_date": dose2, "2nd_dose_batch_num": secondDosebatchNum, "2nd_dose_vacc_type": secondDoseVaccType, "2nd_provider" : secondDoseVaccProvider, "2nd_issued_by" : secondDosageLocation, "2nd_dose_country": secondDoseCountry, "vacc_card_verified": vaccCardVerified, "2nd_dose_upload_date" : secondDoseUploadDate, "shot_type": shotType])
    }
}


struct AddSecondDoseView_Previews: PreviewProvider {
    static var previews: some View {
        AddSecondDoseView()
    }
}
