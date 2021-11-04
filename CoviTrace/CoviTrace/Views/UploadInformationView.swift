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
            // MARK: BACKGROUND COLOUR CODE:
            Background()
            
            VStack {
                VStack(spacing: 10) {
                    
                    // MARK: Log Single Dose
                    HStack {
                        VStack{
                            Button(action: {
                                self.showSingleDoseSheetView.toggle()
                            }, label: {
                                Text("Add Single Dose Vaccination")
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 10)
                            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                                .background(Color.white)
                                .cornerRadius(10)
                                .sheet(isPresented: $showSingleDoseSheetView) {
                                    AddSingleDoseView()
                                }
                        }
                    }
                    
                    // MARK: Log First Vacc Dose
                    HStack {
                        VStack{
                            Button(action: {
                                self.showFirstDoseSheetView.toggle()
                            }, label: {
                                Text("Add First Vaccination Dose")
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 25)
                            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                                .background(Color.white)
                                .cornerRadius(10)
                                .sheet(isPresented: $showFirstDoseSheetView) {
                                    AddFirstDoseView()
                                }
                        }
                    }
                    
                    // MARK: Log Second Vacc Dose
                    HStack {
                        VStack{
                            Button(action: {
                                self.showSecondDoseSheetView.toggle()
                            }, label: {
                                Text("Add Second Vaccination Dose")
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .fontWeight(.semibold)
                            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                                .background(Color.white)
                                .cornerRadius(10)
                                .sheet(isPresented: $showSecondDoseSheetView) {
                                    AddSecondDoseView()
                                }
                        }
                    }
                    
                    // MARK: Upload Booster Shot sheet
                    HStack {
                        VStack {
                            Button(action: {
                                self.showBoosterShotSheetView.toggle()
                            }, label: {
                                Text("Add Vaccination Booster Dose")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                                .background(Color.white)
                                .cornerRadius(10)
                                .sheet(isPresented: $showBoosterShotSheetView) {
                                    AddBoosterShotView()
                                }
                        }
                    }
                    
                    // MARK: Upload Test Results sheet
                    HStack {
                        VStack {
                            Button(action: {
                                self.showUploadPcrTestSheetView.toggle()
                            }, label: {
                                Text("Add Covid PCR Results")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .padding(.trailing, 60)
                            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                                .background(Color.white)
                                .cornerRadius(10)
                                .sheet(isPresented: $showUploadPcrTestSheetView) {
                                    AddResultsView()
                                }
                        }
                    }
                    
                    // MARK: Upload Vaccination Card
                    HStack {
                        VStack{
                            Button(action: {
                                presentImporter = true
                            }, label: {
                                Text("Upload Vaccination Card")
                                    .foregroundColor(Color(.white))
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 50)
                            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .cornerRadius(10)
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
                    }
                    
                    // MARK: Upload Digital Vaccine Cert. sheet
                    HStack {
                        VStack {
                            Button(action: {
                                presentImporter = true
                            }, label: {
                                Text("Upload Vaccination Certificate")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(.white))
                            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .cornerRadius(10)
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
                    }
                    
                    Spacer()
                    
                }.padding()
                
                Spacer()
                
            }
            .navigationBarTitle("Add Vaccination / Test Results", displayMode: .inline)
            
        }
    }
}

