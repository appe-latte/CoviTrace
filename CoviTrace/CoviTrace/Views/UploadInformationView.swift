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
    
    var body: some View {
        //        NavigationView {
        ZStack
        {
            // MARK: BACKGROUND COLOUR CODE:
            Background()
            
            VStack(alignment: .center){
                HStack {
                    VStack(alignment: .center) {
                        
                        // MARK: Log Single Dose
                        HStack {
                            VStack{
                                Button(action: {
                                    self.showSingleDoseSheetView.toggle()
                                }, label: {
                                    Text("Add Single Dose Vaccination")
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        .fontWeight(.semibold)
                                        .padding(.trailing, 20)
                                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                    .padding(5)
                                    .background(Color(.white))
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
                                        .padding(.trailing, 35)
                                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                    .padding(5)
                                    .background(Color(.white))
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
                                        .padding(.trailing, 10)
                                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                    .padding(5)
                                    .background(Color(.white))
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
                                        .padding(.trailing, 10)
                                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                    .padding(5)
                                    .background(Color(.white))
                                    .cornerRadius(10)
                                    .padding(.top, 2)
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
                                        .padding(.trailing, 70)
                                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                    .padding(5)
                                    .background(Color(.white))
                                    .cornerRadius(10)
                                    .padding(.top, 2)
                                    .sheet(isPresented: $showUploadPcrTestSheetView) {
                                        AddResultsView()
                                    }
                            }
                        }
                        
                        // MARK: Upload Vaccination Card
                        HStack {
                            VStack{
                                Button(action: {
                                    // add code to upload vaccination card [.pdf / image]
                                }, label: {
                                    Text("Upload Vaccination Card")
                                        .foregroundColor(Color(.white))
                                        .fontWeight(.semibold)
                                        .padding(.trailing, 50)
                                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                    .padding(5)
                                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .cornerRadius(10)
                            }
                        }
                        
                        // MARK: Upload Digital Vaccine Cert. sheet
                        HStack {
                            VStack {
                                Button(action: {
                                    // add code to upload digital certificate
                                }, label: {
                                    Text("Upload Vaccination Certificate")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(.white))
                                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                    .padding(5)
                                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .cornerRadius(10)
                                    .padding(.top, 2)
                            }
                        }
                        
                        Spacer()
                        
                    }.padding()
                    
                    //                        Spacer()
                }
                Spacer()
                
            }
            .navigationBarTitle("Add Vaccination / Test Results", displayMode: .inline)
            
        }
        //        }
    }
}

struct VaccineDoseSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UploadInformationView()
    }
}

