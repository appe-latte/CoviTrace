//
//  VaccCardView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/06/2021.
//

import SwiftUI
import Firebase

struct VaccCardView: View {
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var firstDosebatchNum = ""
    @State private var secondDosebatchNum = ""
    @State private var firstDoseVaccType = ""
    @State private var secondDoseVaccType = ""
    @State private var firstDoseDate = ""
    @State private var secondDoseDate = ""
    @State private var vaccStatus = ""
    @State private var vaccExpiry = ""
    @State private var firstDosageLocation = ""
    @State private var secondDosageLocation = ""
    @State private var firstDoseVaccProvider = ""
    @State private var secondDoseVaccProvider = ""
    @State var showSheetView = false
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        UITableViewCell.appearance().backgroundColor = UIColor(Color(.white))
    }
    
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
                                        Text("Vaccination Expiry:")
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
                                    Spacer(minLength: 2)
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
                                    }
                                    Divider()
                                    
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
                                    Divider()
                                    
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
                                    Divider()
                                    
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
                                    Divider()
                                    
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
                    }.foregroundColor(Color(.white))
                    
                    // MARK: Second Dosage Info
                    Section(header: Text("Second Dosage")) {
                        List(viewModel.results) { results in
                            VStack(alignment: .leading) {
                                Section {
                                    Spacer(minLength: 2)
                                    // MARK: Date
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
                                    Divider()
                                    
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
                                    Divider()
                                    
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
                                    Divider()
                                    
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
                                    Divider()
                                    
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
