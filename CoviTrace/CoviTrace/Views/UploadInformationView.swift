//
//  UploadInformationView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 14/09/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct UploadInformationView: View {
    @State var showSingleDoseSheetView = false
    @State var showFirstDoseSheetView = false
    @State var showSecondDoseSheetView = false
    @State var showUploadPcrTestSheetView = false
    @State var showBoosterShotSheetView = false
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var boosterModel = BoosterShotViewModel()
    
    @State private var presentImporter = false // presents File importer
    
    var body: some View {
        ZStack
        {
            Background()
            
            VStack {
                VStack(spacing: 30) {
                    
                    // MARK: First Row
                    
                    HStack {
                        
                        // MARK: Log First Vaccine Dose
                        VStack(spacing: 10){
                            Button(action: {
                                self.showFirstDoseSheetView.toggle()
                            }, label: {
                                VStack {
                                    Text("+ First")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                    Text("Dose Jab")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                }
                            }).frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                                .sheet(isPresented: $showFirstDoseSheetView) {
                                    AddFirstDoseView()
                                }
                        }
                        
                        Spacer()
                            .frame(width: 35)
                        
                        // MARK: Log Second Vaccine Dose
                        VStack(spacing: 10){
                            Button(action: {
                                self.showSecondDoseSheetView.toggle()
                            }, label: {
                                VStack {
                                    Text("+ Second")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                    Text("Dose Jab")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                }
                            }).frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                                .sheet(isPresented: $showSecondDoseSheetView) {
                                    AddSecondDoseView()
                                }
                        }
                        
                        Spacer()
                            .frame(width: 30)
                        
                        // MARK: Log Second Vacc Dose
                        VStack(spacing: 10){
                            Button(action: {
                                self.showSingleDoseSheetView.toggle()
                            }, label: {
                                VStack {
                                    Text("+ Single")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                    Text("Dose Jab")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                }
                            }).frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                                .sheet(isPresented: $showSingleDoseSheetView) {
                                    AddSingleDoseView()
                                }
                        }
                    }.frame(minWidth: 0, maxWidth: UIScreen.main.bounds.size.width - 40)
                    
                    // MARK: Second Row
                    
                    HStack {
                        
                        // MARK: Log Booster Vacc Dose
                        VStack(spacing: 10){
                            Button(action: {
                                self.showBoosterShotSheetView.toggle()
                            }, label: {
                                VStack {
                                    Text("+ Booster")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                    Text("Dose")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                }
                            }).frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                                .sheet(isPresented: $showBoosterShotSheetView) {
                                    AddBoosterShotView()
                                }
                        }
                        
                        Spacer()
                            .frame(width: 30)
                        
                        // MARK: Upload Test Results sheet
                        VStack(spacing: 10){
                            Button(action: {
                                self.showUploadPcrTestSheetView.toggle()
                            }, label: {
                                VStack {
                                    Text("+ PCR")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                    Text("Test Results")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                }
                            }).frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                                .sheet(isPresented: $showUploadPcrTestSheetView) {
                                    AddResultsView()
                                }
                        }
                        
                        Spacer()
                            .frame(width: 30)
                        
                        // MARK: Upload Vaccination Card
                        VStack(spacing: 10){
                            Button(action: {
                                presentImporter = true
                            }, label: {
                                VStack {
                                    Text("+ Vaccination")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                    Text("Card")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                }
                            }).frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                                .fileImporter(isPresented: $presentImporter, allowedContentTypes: [.pdf]) { result in
                                    switch result {
                                    case .success(let url):
                                        print(url)
                                        //use `url.startAccessingSecurityScopedResource()` if you are going to read the data
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
                        }
                    }.frame(minWidth: 0, maxWidth: UIScreen.main.bounds.size.width - 40)
                    
                    // MARK: Third Row
                    HStack {
                        // MARK: Upload Digital Vaccine Cert. sheet
                        VStack(spacing: 10){
                            Button(action: {
                                presentImporter = true
                            }, label: {
                                VStack {
                                    Text("+ Digital")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                    Text("Certificate")
                                        .foregroundColor(Color(.white))
                                    .font(.system(size: 10))
                                }
                            }).frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                                .fileImporter(isPresented: $presentImporter, allowedContentTypes: [.pdf]) { result in
                                    switch result {
                                    case .success(let url):
                                        print(url)
                                        //use `url.startAccessingSecurityScopedResource()` if you are going to read the data
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
                        }
                    }.frame(minWidth: 0, maxWidth: UIScreen.main.bounds.size.width - 40)
                    
                    Spacer()
                    
                }.padding()
                
                Spacer()
                
            }
            .navigationBarTitle("Upload Information", displayMode: .inline)
            
        }
    }
}

