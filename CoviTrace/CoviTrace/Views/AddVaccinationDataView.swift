//
//  AddVaccinationDataView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/03/2021.
//

import SwiftUI

struct AddVaccinationDataView: View {
    @State private var vaccRefNum = ""
    @State private var labRefNum = ""
    @State private var hospitalNum = ""
    @State private var vaccDate = Date()
    @State private var vaccCentre = ""
    @State private var vaccType = ""
    @State private var firstDosageDate = Date()
    @State private var secondDosageDate = Date()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        ZStack{
            Background()
            VStack{
                // MARK: Vaccination Reference Number
                SimpleTextField(text: $vaccRefNum, placeholder: Text("Enter Vaccination Reference number"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Lab Ref Number
                SimpleTextField(text: $labRefNum, placeholder: Text("Enter Lab Reference Number"))
                    //                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Hospital Ref Number
                SimpleTextField(text: $hospitalNum, placeholder: Text("Enter Hospital Number"))
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
                SimpleTextField(text: $vaccType, placeholder: Text("Vaccine Make"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
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
                
                Spacer()
            }
        }.navigationBarHidden(false)
    }
}

struct AddVaccinationDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddVaccinationDataView()
    }
}
