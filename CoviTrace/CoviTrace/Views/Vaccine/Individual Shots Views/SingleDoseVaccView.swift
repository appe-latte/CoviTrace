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
    @State var vaccDoseCountry = ""
    
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var singleModel = SingleDoseViewModel()
    
    var body: some View {
        ZStack {
            bgPurple()
            
            Form {
                Section(header: Text("Single Shot Dose")) {
                    List(singleModel.singleDoseData) { singleDoseData in
                        VStack(alignment: .leading, spacing: 15) {
                            Section {
                                
                                // MARK: Single Dose Date
                                HStack {
                                    Text("Date:")
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Spacer()
                                    Text(singleDoseData.singleDoseDate)
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
                                    Text(singleDoseData.singleDosebatchNum)
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
                                    Text(singleDoseData.singleDoseVaccType)
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
                                    Text(singleDoseData.singleDoseLocation)
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
                                    Text(singleDoseData.singleDoseVaccProvider)
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
                                    Text(singleDoseData.vaccDoseCountry)
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
                self.singleModel.fetchData(id: authModel.userSession!.uid)
            }
            
            Spacer()
        }
    }
}
