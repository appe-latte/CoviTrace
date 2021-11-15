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
    @State private var showSingleDoseSheetView = false
    @State private var showFirstDoseSheetView = false
    @State private var showSecondDoseSheetView = false
    @State private var showUploadPcrTestSheetView = false
    @State private var showBoosterShotSheetView = false
    @State private var showVaccCardUploadSheetView = false
    @State private var showDigiCertSheetView = false
    
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var boosterModel = BoosterShotViewModel()
    @ObservedObject private var vaccModel = VaccinationViewModel()
    
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
                                self.showVaccCardUploadSheetView.toggle()
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
                                .sheet(isPresented: $showVaccCardUploadSheetView) {
                                    VaccCardUploadView()
                                }
                        }
                    }.frame(minWidth: 0, maxWidth: UIScreen.main.bounds.size.width - 40)
                    
                    // MARK: Third Row
                    HStack {
                        // MARK: Upload Digital Vaccine Cert. sheet
                        VStack(spacing: 10){
                            Button(action: {
                                self.showDigiCertSheetView.toggle()
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
                                .sheet(isPresented: $showDigiCertSheetView) {
                                    DigitalCertUploadView()
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

func uploadVaccCardImage(image:UIImage){
    if let imageData = image.jpegData(compressionQuality: 1){
        let storage = Storage.storage()
        storage.reference().child("vaccination_card").putData(imageData, metadata: nil){
            (_, err) in
            if let err = err {
                print("an error has occurred - \(err.localizedDescription)")
            } else {
                print("image uploaded successfully")
            }
        }
    } else {
        print("coldn't unwrap/case image to data")
    }
}
