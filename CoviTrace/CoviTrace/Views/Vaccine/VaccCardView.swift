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
        UITableView.appearance().backgroundColor = UIColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        UITableViewCell.appearance().backgroundColor = UIColor(Color(.white))
    }
    
    var body: some View {
        ZStack {
            
            VStack {
                //                Spacer()
                //                HStack{
                //                    Text("Vaccination Information")
                //                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                //                        .font(.system(size: 18).bold())
                //                        .padding(.leading, 100)
                //                        .padding(5)
                //
                //                    Spacer()
                //                }
                
                Form {
                    Section(header: Text("Status")) {
                        List(viewModel.results) { results in
                            VStack(alignment: .leading, spacing: 15) {
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
                    }.foregroundColor(Color(.white))
                    
                    // MARK: Single Shot Information
                    HStack {
                        NavigationLink(
                            destination: SingleDoseVaccView()){
                                HStack {
                                    Text("Single Dose")
                                        .font(.subheadline)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                            }
                    }
                    
                    // MARK: First Shot Information
                    HStack {
                        NavigationLink(
                            destination: FirstDoseVaccView()){
                                HStack {
                                    Text("First Dose")
                                        .font(.subheadline)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                            }
                    }
                    
                    // MARK: Second Shot Information
                    HStack {
                        NavigationLink(
                            destination: secondDoseVaccView()){
                                HStack {
                                    Text("Second Dose")
                                        .font(.subheadline)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                            }
                    }
                    
                    // MARK: Booster Shot Information
                    HStack {
                        NavigationLink(
                            destination: BoosterVaccView()){
                                HStack {
                                    Text("Booster Shot")
                                        .font(.subheadline)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                            }
                    }
                    
                }
                .onAppear() {
                    self.viewModel.fetchData(id: authModel.userSession!.uid)
                }
                //                Spacer()
            }
        }.navigationBarTitle("Vaccination Information", displayMode: .inline)
    }
}
