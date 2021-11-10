//
//  VaccineDoseSelectionView.swift
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
                        VStack{
                            Button(action: {
                                self.showFirstDoseSheetView.toggle()
                            }, label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .font(.footnote)
                                    .foregroundColor(Color(.white))
                                    .padding(10)
                            }).frame(width: 75, height: 75)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                                .sheet(isPresented: $showFirstDoseSheetView) {
                                    AddFirstDoseView()
                                }
                            
                            Text("First Dose")
                                .foregroundColor(Color(.white))
                                .font(.footnote)
                        }
                        
                        Spacer()
                            .frame(width: 35)
                        
                        // MARK: Log Second Vaccine Dose
                        VStack {
                            Button(action: {
                                self.showSecondDoseSheetView.toggle()
                            }, label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .font(.footnote)
                                    .foregroundColor(Color(.white))
                                    .padding(10)
                            }).frame(width: 75, height: 75)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                                .sheet(isPresented: $showSecondDoseSheetView) {
                                    AddSecondDoseView()
                                }
                            Text("Second Dose")
                                .foregroundColor(Color(.white))
                                .font(.footnote)
                        }
                        
                        Spacer()
                            .frame(width: 30)
                        
                        // MARK: Log Second Vacc Dose
                        VStack{
                            Button(action: {
                                self.showSingleDoseSheetView.toggle()
                            }, label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .font(.footnote)
                                    .foregroundColor(Color(.white))
                                    .padding(10)
                            }).frame(width: 75, height: 75)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                                .sheet(isPresented: $showSingleDoseSheetView) {
                                    AddSingleDoseView()
                                }
                            
                            Text("Single Dose")
                                .foregroundColor(Color(.white))
                                .font(.footnote)
                        }
                    }
                    
                    // MARK: Second Row
                    
                    HStack {
                        
                        // MARK: Log Booster Vacc Dose
                        VStack(spacing: 10){
                            Button(action: {
                                self.showBoosterShotSheetView.toggle()
                            }, label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .font(.footnote)
                                    .foregroundColor(Color(.white))
                                    .padding(10)
                            }).frame(width: 75, height: 75)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                                .sheet(isPresented: $showBoosterShotSheetView) {
                                    AddBoosterShotView()
                                }
                            
                            Text("Booster Dose")
                                .foregroundColor(Color(.white))
                                .font(.footnote)
                        }
                        
                        Spacer()
                            .frame(width: 30)
                        
                        // MARK: Upload Test Results sheet
                        VStack(spacing: 10){
                            Button(action: {
                                self.showUploadPcrTestSheetView.toggle()
                            }, label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .font(.footnote)
                                    .foregroundColor(Color(.white))
                                    .padding(10)
                            }).frame(width: 75, height: 75)
                                .foregroundColor(.white)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                                .sheet(isPresented: $showUploadPcrTestSheetView) {
                                    AddResultsView()
                                }
                            Text("PCR Results")
                                .foregroundColor(Color(.white))
                                .font(.footnote)
                        }
                        
                        Spacer()
                            .frame(width: 30)
                        
                        // MARK: Upload Vaccination Card
                        VStack(spacing: 10){
                            Button(action: {
                                presentImporter = true
                            }, label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .font(.footnote)
                                    .foregroundColor(Color(.white))
                                    .padding(10)
                            }).frame(width: 75, height: 75)
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
                            
                            Text("Vaccination Card")
                                .foregroundColor(Color(.white))
                                .font(.system(size: 12))
                        }
                    }
                    
                    // MARK: Upload Digital Vaccine Cert. sheet
                    HStack {
                        VStack(spacing: 10){
                            Button(action: {
                                presentImporter = true
                            }, label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .font(.footnote)
                                    .foregroundColor(Color(.white))
                                    .padding(10)
                            }).frame(width: 75, height: 75)
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
                            
                            Text("Digital Certificate")
                                .foregroundColor(Color(.white))
                                .font(.system(size: 12))
                        }
                    }
                    
                    Spacer()
                    
                }.padding()
                
                Spacer()
                
            }
            .navigationBarTitle("Upload Information", displayMode: .inline)
            
        }
    }
}

