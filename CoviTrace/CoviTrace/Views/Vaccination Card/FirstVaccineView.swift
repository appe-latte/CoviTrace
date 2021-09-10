//
//  FirstVaccineView.swift
//  FirstVaccineView
//
//  Created by Stanford L. Khumalo on 03/08/2021.
//

import SwiftUI
import Firebase

struct FirstVaccineView: View {
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var firstDosebatchNum = ""
    @State private var firstDoseVaccType = ""
    @State private var firstDoseDate = ""
    @State private var firstDosageLocation = ""
    @State private var firstDoseVaccProvider = ""
    @State private var firstVaccinationCountry = ""
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                Spacer()
                HStack{
                    Text("Vaccination Information")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .padding(5)
                    
                    Spacer()
                }
                Divider()
                
                Form {
                    Section(header: Text("Status")) {
                        List(viewModel.results) { results in
                            VStack(alignment: .leading) {
                                Section {
                                    // MARK: Vaccination Status
                                    HStack {
                                        Text("Vaccination Status:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(results.vaccStatus)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }
                                    Divider()
                                    
                                    // MARK: Expiry
                                    HStack {
                                        Text("Vaccination Period:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(results.vaccExpiry)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }
                                }
                            }
                        }
                    }.foregroundColor(Color(.white))
                    
                    // MARK: First Dosage Info
                    Section(header: Text("First Dosage")) {
                        List(viewModel.results) { results in
                            VStack(alignment: .leading) {
                                Section {
                                    //                                    Spacer(minLength: 2)
                                    // MARK: Date
                                    HStack {
                                        Text("Date:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(results.firstDoseDate)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }.padding(.vertical, 5)
                                    
                                    // MARK: Batch Number
                                    HStack {
                                        Text("Batch Number:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(results.firstDosebatchNum)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }.padding(.vertical, 5)
                                    
                                    // MARK: Vaccine Make
                                    HStack {
                                        Text("Vaccine Make:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(results.firstDoseVaccType)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }.padding(.vertical, 5)
                                    
                                    // MARK: Vaccination Location
                                    HStack {
                                        Text("Location:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(results.firstDosageLocation)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }.padding(.vertical, 5)
                                    
                                    // MARK: Vaccination Provider
                                    HStack {
                                        Text("Provider:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(results.firstDoseVaccProvider)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }.padding(.vertical, 5)
                                    
                                    
                                    // MARK: Vaccination Country
                                    HStack {
                                        Text("Country:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(results.firstVaccinationCountry)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }.padding(.vertical, 5)
                                }
                            }
                        }
                    }.foregroundColor(Color(.white))
                }
                .onAppear() {
                    self.viewModel.fetchData(id: authModel.userSession!.uid)
                }
                Spacer()
            }
        }
    }
}

struct FirstVaccineView_Previews: PreviewProvider {
    static var previews: some View {
        FirstVaccineView()
    }
}
