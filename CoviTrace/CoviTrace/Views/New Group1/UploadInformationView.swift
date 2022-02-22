//
//  UploadInformationView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 14/09/2021.
//

import SwiftUI
import Combine
import Firebase
import FirebaseFirestore

struct UploadInformationView: View {
    @State private var showSingleDoseSheetView = false
    @State private var showFirstDoseSheetView = false
    @State private var showSecondDoseSheetView = false
    @State private var showBoosterShotSheetView = false
    
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var boosterModel = BoosterShotViewModel()
    @ObservedObject private var vaccModel = FirstDoseVaccViewModel()
    
    @State private var presentImporter = false // presents File importer
    
    var body: some View {
        ZStack {
            VStack {
                
                Spacer()
                    .frame(height: 20)
                
                HStack(spacing: 15) {
                    
                    // MARK: Log First Vaccine Dose
                    Button(action: {
                        self.showFirstDoseSheetView.toggle()
                    }, label: {
                        VStack {
                            Text("+ First")
                                .foregroundColor(Color.white)
                                .font(.system(size: 10))
                            Text("Dose")
                                .foregroundColor(Color.white)
                                .font(.system(size: 10))
                        }
                    }).buttonStyle(purpleRoundButton())
                        .sheet(isPresented: $showFirstDoseSheetView) {
                            AddFirstDoseView()
                        }
                    
                    // MARK: Log Second Vaccine Dose
                    Button(action: {
                        self.showSecondDoseSheetView.toggle()
                    }, label: {
                        VStack {
                            Text("+ Second")
                                .foregroundColor(Color.white)
                                .font(.system(size: 10))
                            Text("Dose")
                                .foregroundColor(Color.white)
                                .font(.system(size: 10))
                        }
                    }).buttonStyle(purpleRoundButton())
                        .sheet(isPresented: $showSecondDoseSheetView) {
                            AddSecondDoseView()
                        }
                    
                    // MARK: Log Single Dose
                    Button(action: {
                        self.showSingleDoseSheetView.toggle()
                    }, label: {
                        VStack {
                            Text("+ Single")
                                .foregroundColor(Color.white)
                                .font(.system(size: 10))
                            Text("Dose")
                                .foregroundColor(Color.white)
                                .font(.system(size: 10))
                        }
                    }).buttonStyle(purpleRoundButton())
                        .sheet(isPresented: $showSingleDoseSheetView) {
                            AddSingleDoseView()
                        }
                    
                    // MARK: Log Booster Vacc Dose
                    Button(action: {
                        self.showBoosterShotSheetView.toggle()
                    }, label: {
                        VStack {
                            Text("+ Booster")
                                .foregroundColor(Color.white)
                                .font(.system(size: 10))
                            Text("Dose")
                                .foregroundColor(Color.white)
                                .font(.system(size: 10))
                        }
                    }).buttonStyle(purpleRoundButton())
                        .sheet(isPresented: $showBoosterShotSheetView) {
                            AddBoosterShotView()
                        }
                }.frame(minWidth: 0, maxWidth: UIScreen.main.bounds.size.width - 40)
                
                Spacer()
            }
        }
    }
}
