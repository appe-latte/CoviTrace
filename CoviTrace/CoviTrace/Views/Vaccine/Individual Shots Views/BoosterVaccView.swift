//
//  BoosterVaccView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 26/10/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct BoosterVaccView: View {
    @State var boosterDosebatchNum = ""
    @State var boosterDoseVaccType = ""
    @State var boosterDoseDate = ""
    @State var boosterDoseLocation = ""
    @State var boosterDoseVaccProvider = ""
    @State var boosterDoseCountry = ""
    
    @ObservedObject private var boosterModel = BoosterShotViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
    var body: some View {
        ZStack {
            Background()
            Form {
                // MARK: Booster Shot Information
                Section(header: Text("Booster Shot")) {
                    List(boosterModel.boosterData) { boosterData in
                        VStack(alignment: .leading, spacing: 15) {
                            Section {
                                
                                // MARK: Booster Shot Date
                                HStack {
                                    Text("Date:")
                                        .font(.custom("Avenir", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(boosterData.boosterDoseDate)
                                        .font(.custom("Avenir", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                                
                                // MARK: Booster Vaccine Batch Number
                                HStack {
                                    Text("Batch Number:")
                                        .font(.custom("Avenir", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(boosterData.boosterDosebatchNum)
                                        .font(.custom("Avenir", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                                
                                // MARK: Booster Vaccine Make
                                HStack {
                                    Text("Vaccine Make:")
                                        .font(.custom("Avenir", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(boosterData.boosterDoseVaccType)
                                        .font(.custom("Avenir", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                                
                                // MARK: Booster Vaccination Location
                                HStack {
                                    Text("Location:")
                                        .font(.custom("Avenir", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(boosterData.boosterDoseLocation)
                                        .font(.custom("Avenir", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                                
                                // MARK: Booster Vaccination Provider
                                HStack {
                                    Text("Provider:")
                                        .font(.custom("Avenir", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(boosterData.boosterDoseVaccProvider)
                                        .font(.custom("Avenir", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                                
                                // MARK: Booster Vaccination Country
                                HStack {
                                    Text("Country:")
                                        .font(.custom("Avenir", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(boosterData.boosterDoseCountry)
                                        .font(.custom("Avenir", size: 16))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                            }
                        }
                    }
                }.foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
            }
            .onAppear() {
                self.boosterModel.fetchData(id: authModel.userSession!.uid)
            }
            Spacer()
        }
    }
}
