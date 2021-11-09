//
//  SingleDoseVaccView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 26/10/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct SingleDoseVaccView: View {
    @State var singleDosebatchNum = ""
    @State var singleDoseVaccType = ""
    @State var singleDoseDate = ""
    @State var singleDoseLocation = ""
    @State var singleDoseVaccProvider = ""
    @State var singleDoseCountry = ""
    
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var singleModel = SingleDoseViewModel()
    
    var body: some View {
        ZStack {
            Background()
            Form {
                Section(header: Text("Single Shot Dose")) {
                    List(singleModel.singleDoseData) { singleDoseData in
                        VStack(alignment: .leading, spacing: 15) {
                            Section {
                                
                                // MARK: First Dose Date
                                HStack {
                                    Text("Date:")
                                        .font(.subheadline)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(singleDoseData.singleDoseDate)
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
                                    Text(singleDoseData.singleDosebatchNum)
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
                                    Text(singleDoseData.singleDoseVaccType)
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
                                    Text(singleDoseData.singleDoseLocation)
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
                                    Text(singleDoseData.singleDoseVaccProvider)
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
                                    Text(singleDoseData.singleDoseCountry)
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
                self.singleModel.fetchData(id: authModel.userSession!.uid)
            }
            Spacer()
        }
    }
}
