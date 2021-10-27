//
//  SecondDoseVaccView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 26/10/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct secondDoseVaccView: View {
    @State var secondDosebatchNum = ""
    @State var secondDoseVaccType = ""
    @State var secondDoseDate = ""
    @State var secondDosageLocation = ""
    @State var secondDoseVaccProvider = ""
    @State var secondDoseCountry = ""
    
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var viewModel = VaccinationViewModel()
    
    var body: some View {
        ZStack {
            Background()
            Form {
                // MARK: Second Dose Information
                Section(header: Text("Second Vaccine Dose")) {
                    List(viewModel.results) { results in
                        VStack(alignment: .leading, spacing: 15) {
                            Section {
                                
                                // MARK: Second Dose Date
                                HStack {
                                    Text("Date:")
                                        .font(.subheadline)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(results.secondDoseDate)
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
                                    Text(results.secondDosebatchNum)
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
                                    Text(results.secondDoseVaccType)
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
                                    Text(results.secondDosageLocation)
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
                                    Text(results.secondDoseVaccProvider)
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
                                    Text(results.secondDoseCountry)
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
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
