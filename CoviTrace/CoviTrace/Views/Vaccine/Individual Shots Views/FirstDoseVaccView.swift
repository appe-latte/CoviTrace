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
    @State var firstVaccDoseCountry = ""
    
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var doseModel = FirstDoseVaccViewModel()
    
    var body: some View {
        ZStack {
            Background()
            Form {
                // MARK: Booster Shot Information
                Section(header: Text("First Vaccine Dose")) {
                    List(doseModel.firstDoseData) { firstDoseData in
                        VStack(alignment: .leading, spacing: 15) {
                            Section {
                                
                                // MARK: First Dose Date
                                HStack {
                                    Text("Date:")
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(firstDoseData.firstDoseDate)
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                                
                                // MARK: Batch Number
                                HStack {
                                    Text("Batch Number:")
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(firstDoseData.firstDosebatchNum)
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                                
                                // MARK: Vaccine Make
                                HStack {
                                    Text("Vaccine Make:")
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(firstDoseData.firstDoseVaccType)
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                                
                                // MARK: Vaccination Location
                                HStack {
                                    Text("Location:")
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(firstDoseData.firstDosageLocation)
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                                
                                // MARK: Vaccination Provider
                                HStack {
                                    Text("Provider:")
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(firstDoseData.firstDoseVaccProvider)
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                                
                                // MARK: Vaccination Country
                                HStack {
                                    Text("Country:")
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(firstDoseData.firstVaccDoseCountry)
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                            }
                        }
                    }
                }.foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
            }
            .onAppear() {
                self.doseModel.fetchData(id: authModel.userSession!.uid)
            }
            Spacer()
        }
    }
}
