//
//  VaccPassView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 24/10/2021.
//

import SwiftUI
import Combine
import Firebase
import CryptoKit
import AlertToast
import FirebaseFirestore
import CoreImage.CIFilterBuiltins

struct VaccPassView: View {
    @State var lastName = ""
    @State var firstName = ""
    @State var vaccStatus = ""
    @State var dob = ""
    @State var idNum = ""
    
    @ObservedObject var firstDoseVaccModel = FirstDoseVaccViewModel()
    @ObservedObject var secondDoseVaccModel = SecondDoseVaccViewModel()
    @ObservedObject var authModel = AuthViewModel()
    @ObservedObject var boosterModel = BoosterShotViewModel()
    
    @State var activeSheet: ActiveSheet?
    
    @State private var showFirstDoseSheetView = false
    @State private var showSecondDoseSheetView = false
    @State private var showSingleDoseSheetView = false
    @State private var showBoosterDoseSheetView = false
    
    @State var selectDose: doseSelection = .first
    @State var formHalfModal_shown = false
    @State var showActionSheet = false
    
    // MARK: Alert
    @State var showIdTypeAlert = false
    @State var alertTitle = ""
    @State var alertMessage = "Approved ID includes: a valid Passport, National ID, a Driver's Licence and a Military / Police ID."
    
    // MARK: for QR Code generation
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color(.white))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                //                Spacer()
                
                Text("Certificate of Vaccination")
                    .multilineTextAlignment(.leading)
                    .font(.custom("Avenir", size: 22).bold())
                    .foregroundColor(Color(.white))
                    .padding(.horizontal)
                //                    .padding(.top, 25)
                
                let fullName = authModel.user!.firstName + " " + authModel.user!.lastName
                let dob = authModel.user!.dob
                let idNum = authModel.user!.idNumber
                
                HStack {
                    // MARK: ID Number
                    Text(authModel.user!.idNumber)
                        .font(.custom("Avenir", size: 12))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.white))
                    
                    Spacer()
                    
                    // MARK: User's full name
                    Text(fullName)
                        .font(.custom("Avenir", size: 12))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.white))
                    
                }.padding(.horizontal, 20)
                    .padding(.vertical, 5)
                
                // MARK: QR Code and Certificate information
                List(firstDoseVaccModel.firstDoseData) { firstDoseData in
                    VStack {
                        HStack {
                            Image(uiImage: generateQRCode(from: " Name: \(fullName)\n Status: \(firstDoseData.vaccStatus)\n DOB: \(dob)\n ID: \(idNum)"))
                                .interpolation(.none)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 175, height: 175)
                                .padding(5)
                        }
                        
                        // MARK: Disclaimer
                        HStack {
                            Button(action: {
                                self.showIdTypeAlert.toggle()
                            }, label: {
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            })
                            
                            Text("This pass is only acceptable when accompanied with a valid government identity document.")
                                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 60, alignment: .center)
                                .font(.custom("Avenir", size: 12).bold())
                                .multilineTextAlignment(.leading)
                                .lineLimit(10)
                        }
                    }
                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                } .toast(isPresenting: $showIdTypeAlert){
                    AlertToast(type: .regular, title: "Approved ID", subTitle: "\(alertMessage)")
                }
                
                VStack {
                    HStack {
                        Text("Vaccination Information")
                            .foregroundColor(.white)
                            .font(.custom("Avenir", size: 16))
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            self.showActionSheet.toggle()
                        }, label: {
                            Text("+ add vaccination")
                                .foregroundColor(purple)
                                .font(.custom("Avenir", size: 12))
                                .fontWeight(.bold)
                        }).frame(width: 110, height: 20)
                            .background(bgWhite())
                            .cornerRadius(5)
                            .actionSheet(isPresented: $showActionSheet) {
                                ActionSheet(title: Text("Select Vaccination"), message: Text("Pick which vaccination type to upload"), buttons: [
                                    .default(Text("Add First Dose")){
                                        activeSheet = .first
                                    },
                                    .default(Text("Add Second Dose")){
                                        activeSheet = .second
                                    },
                                    .default(Text("Add Single Dose")){
                                        activeSheet = .single
                                    },
                                    .default(Text("Add Booster Dose")){
                                        activeSheet = .booster
                                    },
                                    .cancel()
                                ])
                            }
                    }.padding(.horizontal)
                        .sheet(item: $activeSheet) { item in
                            switch item {
                            case .first:
                                AddFirstDoseView()
                            case .second:
                                AddSecondDoseView()
                            case .single:
                                AddSingleDoseView()
                            case .booster:
                                AddBoosterShotView()
                            }
                        }
                    
                    // MARK: Segmented Control for Dose Selection
                    Picker("Dose Selection:", selection: $selectDose) {
                        ForEach(doseSelection.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                        
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal, 5)
                        .padding(.top, 10)
                    doseSelectionView(selectedDose: selectDose)
                }
            }.onAppear() {
                self.firstDoseVaccModel.fetchData(id: authModel.userSession!.uid)
                
            }.padding(.top, 20)
        }.background(bgPurple())
            .navigationBarTitle("Vaccination Pass")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Function for creating QR code
    func generateQRCode(from string: String) -> UIImage {
        let encryptedString = string.aesEncrypt(key: "MxGChe28!oLWavj*fmiQdq@kbYNB@jGP6-*qJtH*z2P9ptsG-kJdTfhbyDTpRC!6F*6dvYh6QLAt") ?? ""
        let data = Data(encryptedString.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

// MARK: Structure for Segmented picker
enum doseSelection: String, CaseIterable {
    case first = "First"
    case second = "Second"
    case single = "Single"
    case booster = "Booster"
}

struct doseSelectionView : View {
    var selectedDose: doseSelection
    
    var body: some View {
        switch selectedDose {
        case .first:
            FirstDoseVaccView()
        case .second:
            SecondDoseVaccView()
        case .single:
            SingleDoseVaccView()
        case .booster:
            BoosterVaccView()
        }
    }
}

// MARK: Dosage sheet selection
enum ActiveSheet: Identifiable {
    case first, second, single, booster
    
    var id: Int {
        hashValue
    }
}
