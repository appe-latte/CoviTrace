//
//  AddVaccinationDataView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/03/2021.
//

import SwiftUI

struct AddVaccinationDataView: View {
    @State private var batchNum = ""
    @State private var vaccDate = Date()
    @State private var vaccCentre = ""
    @State private var vaccType = ""
    @State private var firstDosageDate = Date() // Same date as the vaccDate
    @State private var secondDosageDate = Date()
    
    // MARK: Vaccines
    var vaccineTypes = ["Pfizer-BioNTech", "Moderna", "AstraZeneca", "Johnson & Johson", "Novavax"]
    @State private var selectedVaccine = "Select Vaccine type"
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        ZStack{
            Background()
            VStack{
                // MARK: Batch Number
                SimpleTextField(text: $batchNum, placeholder: Text("Enter Batch number"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Vaccination Location
                SimpleTextField(text: $vaccCentre, placeholder: Text("Enter Test Location"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Vaccination Date
                DatePicker(selection: $vaccDate, in: ...Date(), displayedComponents: .date) {
                    Text("Vaccination Date")
                        .padding(.leading, 15)
                }
                .foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                .background(Color(.white).opacity(0.1))
                .cornerRadius(15)
                .font(.footnote)
                
                // MARK: Vaccination Make
                VStack{
                    Picker("Vaccine Type", selection: $selectedVaccine) {
                        ForEach(vaccineTypes, id: \.self) {
                            Text($0)
                        }
                    }
                }
                .foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                .background(Color(.white).opacity(0.1))
                .cornerRadius(15)
                .font(.footnote)
                
                // MARK: First Dose Date
                DatePicker(selection: $firstDosageDate, in: ...Date(), displayedComponents: .date) {
                    Text("First Dosage Date")
                        .padding(.leading, 15)
                }
                .foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                .background(Color(.white).opacity(0.1))
                .cornerRadius(15)
                .font(.footnote)
                
                // MARK: Second Dose Date
                DatePicker(selection: $secondDosageDate, in: ...Date(), displayedComponents: .date) {
                    Text("Second Dosage Date")
                        .padding(.leading, 15)
                }
                .foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                .background(Color(.white).opacity(0.1))
                .cornerRadius(15)
                .font(.footnote)
                
                
                // MARK: "Log Results" Button
                Button(action: {
                    
                }, label: {
                    Text("LOG RESULTS")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading,10)
                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                .cornerRadius(30)
                .padding(.top, 2)
                
                //                Spacer()
            }
        }.navigationBarHidden(false)
    }
}

struct AddVaccinationDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddVaccinationDataView()
    }
}
