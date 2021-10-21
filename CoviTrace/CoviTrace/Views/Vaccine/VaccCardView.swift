//
//  VaccCardView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/06/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct VaccCardView: View {
    
    // MARK: First Dosage
    @State var firstDosebatchNum = ""
    @State var firstDoseVaccType = ""
    @State var firstDoseDate = ""
    @State var firstDosageLocation = ""
    @State var firstDoseVaccProvider = ""
    
    // MARK: Second Dosage
    @State var secondDoseVaccType = ""
    @State var secondDosebatchNum = ""
    @State var secondDoseDate = ""
    @State var secondDosageLocation = ""
    @State var secondDoseVaccProvider = ""
    
    // MARK: Booster Shot
    @State var boosterDosebatchNum = ""
    @State var boosterDoseVaccType = ""
    @State var boosterDoseDate = ""
    @State var boosterDoseLocation = ""
    @State var boosterDoseVaccProvider = ""
    @State var boosterDoseCountry = ""
    
    @State var vaccStatus = ""
    @State var vaccExpiry = ""
    @State var vaccDoseCountry = ""
    @State var shotType = ""
    @State var vaccCardVerified = ""
    
    @State var showSheetView = false
    
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var boosterModel = BoosterShotViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color(.white))
        UITableViewCell.appearance().backgroundColor = UIColor(Color(.white))
    }
    
    var body: some View {
        ZStack {
            
            VStack {
                Spacer()
                HStack{
                    Text("Vaccination Information")
                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        .font(.system(size: 18).bold())
                        .padding(.leading, 100)
                        .padding(5)
                    
                    Spacer()
                }
                
                Form {
                    Section(header: Text("Status")) {
                        List(viewModel.results) { results in
                            VStack(alignment: .leading, spacing: 15) {
                                Section {
                                    
                                    // MARK: Vaccination Types
                                    HStack {
                                        Text("Dosage Type:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(results.shotType)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }
                                    
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
                                    
                                    // MARK: Vaccination Country
                                    HStack {
                                        Text("Country:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(results.vaccDoseCountry)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }
                                    
                                    // MARK: Expiry
                                    HStack {
                                        Text("Vaccination Expiry:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(results.vaccExpiry)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }
                                    
                                    // MARK: Vaccination Card Verified
                                    HStack {
                                        Text("Vaccination Verified:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(results.vaccCardVerified)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }
                                }
                            }
                        }
                    }.foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                    
                    // MARK: First Dosage Info
                    Section(header: Text("First Dosage")) {
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
                                    
                                }
                            }
                        }
                    }.foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                    
                    // MARK: Second Dosage Info
                    
                    Section(header: Text("Second Dosage")) {
                        List(viewModel.results) { results in
                            VStack(alignment: .leading, spacing: 15) {
                                Section {
                                    
                                    // MARK: First Dose Date
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
                                }
                            }
                        }
                    }.foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                    
                    // MARK: Booster Shot Information
                    Section(header: Text("Booster Shot")) {
                        List(boosterModel.boosterData) { boosterData in
                            VStack(alignment: .leading, spacing: 15) {
                                Section {
                                    
                                    // MARK: Booster Shot Date
                                    HStack {
                                        Text("Date:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(boosterData.boosterDoseDate)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }
                                    
                                    // MARK: Booster Vaccine Batch Number
                                    HStack {
                                        Text("Batch Number:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(boosterData.boosterDosebatchNum)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }
                                    
                                    // MARK: Booster Vaccine Make
                                    HStack {
                                        Text("Vaccine Make:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(boosterData.boosterDoseVaccType)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }
                                    
                                    // MARK: Booster Vaccination Location
                                    HStack {
                                        Text("Location:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(boosterData.boosterDoseLocation)
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    }
                                    
                                    // MARK: Booster Vaccination Provider
                                    HStack {
                                        Text("Provider:")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        Spacer()
                                        Text(boosterData.boosterDoseVaccProvider)
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
}
