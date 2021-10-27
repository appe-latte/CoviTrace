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
    @State var singleDoseCountry = ""
    @State var vaccCardVerified = "verification pending"
    @State var shotType = "Single Dose"
    @State var singleDoseUploadDate = Date() // Logs the date the dose is uploaded onto the system.
    
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    @State var showImagePicker = false
    
    func loadImage(){
        guard let selectedImage = selectedUIImage else {return}
        image = Image(uiImage: selectedImage)
    }
    
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
                    Text("Add Single Dosage Information")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .padding(.top, 15)
                
                VStack {
                    // MARK: Single Dose Date
                    DatePicker(selection: $singleDoseDate, in: ...Date(), displayedComponents: .date) {
                        Text("Choose Date:")
                            .padding(.leading)
                            .foregroundColor(Color(.white)).font(.system(size: 14))
                    }.foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1)).font(.system(size: 12))
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
                    SimpleTextField(text: $singleDoseCountry, placeholder: Text("Vaccination Country"))
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
    
    // MARK: Upload to "Single Dose" DB
    
    func upload_data(){
        let db = Firestore.firestore()
        let dose4 = dateFormatter.string(from: singleDoseDate)
        db.collection("single_dose").document().setData(["userId": authModel.userSession!.uid, "single_date": dose4, "single_batch_num": singleDosebatchNum, "single_vacc_type": singleDoseVaccType, "single_provider": singleDoseVaccProvider, "single_issued_by" : singleDoseLocation, "single_dose_country": singleDoseCountry, "vacc_card_verified": vaccCardVerified, "single_dose_upload_date": singleDoseUploadDate, "shotType": shotType])
    }
}

struct AddSingleDoseView_Previews: PreviewProvider {
    static var previews: some View {
        AddSingleDoseView()
    }
}
