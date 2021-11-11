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
    @State var shotType = "First Dose"
    @State var vaccStatus = "First Dose Administered"
    @State var firstDosageLocation = ""
    @State var firstDoseVaccProvider = ""
    @State var vaccDoseCountry = ""
    @State var firstDoseUploadDate = Date() // Logs the date the first dose is uploaded onto the system.
    @State var vaccCardVerified = "Verification Pending"
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    let vaccineType = ["Pfizer-BioNTech", "Moderna", "AstraZeneca", "Johnson & Johnson"]
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    // MARK: Image Picker
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    @State var showImagePicker = false
    
    func loadImage(){
        guard let selectedImage = selectedUIImage else {return}
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        ZStack{
            Background()
            VStack {
                VStack{
                    Text("Add First Dosage Information")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .padding(.top, 15)
                
                VStack {
                    // MARK: First Dose Date
                    DatePicker(selection: $firstDoseDate, in: ...Date(), displayedComponents: .date) {
                        Text("Choose Date:")
                            .padding(.leading)
                            .foregroundColor(Color(.white)).font(.system(size: 14))
                    }.foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1)).font(.system(size: 12))
                        .cornerRadius(10)
                    
                    // MARK: First Dose Batch Number
                    SimpleTextField(text: $firstDosebatchNum, placeholder: Text("Batch Number"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: First Dose Vaccination Make
                    HStack {
                        Text("Vaccine Type:")
                            .padding(.leading)
                            .foregroundColor(Color(.white)).font(.system(size: 14))
                        
                        Spacer()
                        
                        Picker("Vaccine Type", selection: $firstDoseVaccType) {
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
                        showImagePicker.toggle()
                    }, label: {
                        Text("Upload Vaccine Card")
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .fontWeight(.semibold)
                            .padding(.trailing, 10)
                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.top, 2)
                        .sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                            ImagePicker(image: $selectedUIImage)
                        })
                    
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
        db.collection("vaccinations").document().setData(["userId": authModel.userSession!.uid, "1st_dose_date": dose1, "1st_dose_batch_num": firstDosebatchNum, "1st_dose_vacc_type": firstDoseVaccType, "1st_provider" : firstDoseVaccProvider, "1st_issued_by" : firstDosageLocation, "vacc_dose_country": vaccDoseCountry, "vacc_card_verified": vaccCardVerified, "1st_dose_upload_date": firstDoseUploadDate, "shot_type": shotType ])
    }
}

