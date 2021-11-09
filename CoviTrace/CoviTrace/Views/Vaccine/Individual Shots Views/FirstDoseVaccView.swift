//
//  FirstDoseVaccView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 26/10/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct FirstDoseVaccView: View {
    // MARK: First Dosage
    @State var firstDosebatchNum = ""
    @State var firstDoseVaccType = ""
    @State var firstDoseDate = ""
    @State var firstDosageLocation = ""
    @State var firstDoseVaccProvider = ""
    @State var firstDoseCountry = ""
    
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var viewModel = VaccinationViewModel()
    
    var body: some View {
        ZStack {
            Background()
            Form {
                // MARK: Booster Shot Information
                Section(header: Text("First Vaccine Dose")) {
                    List(viewModel.results) { results in
                        VStack(alignment: .leading, spacing: 15) {
                            Section {
                                
                                // MARK: First Dose Date
                                HStack {
                                    Text("Date:")
                                        .font(.subheadline)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(results.firstDoseDate)
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                                
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
                                }
                                
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
                                }
                                
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
                                }
                                
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
                                }
                                
                                // MARK: Vaccination Country
                                HStack {
                                    Text("Country:")
                                        .font(.subheadline)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(results.firstDoseCountry)
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                            }
                        }
                    }
                }.foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
            }
            .onAppear() {
                self.viewModel.fetchData(id: authModel.userSession!.uid)
            }
            Spacer()
        }
    }
}
