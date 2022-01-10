//
//  VaccPassView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 24/10/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import CoreImage.CIFilterBuiltins
import CryptoKit

struct VaccPassView: View {
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var vaccStatus = ""
    @State private var dob = ""
    @State private var idNum = ""
    
    @ObservedObject private var firstDoseVaccModel = FirstDoseVaccViewModel()
    @ObservedObject private var secondDoseVaccModel = SecondDoseVaccViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var boosterModel = BoosterShotViewModel()
    
    @State private var selectDose: doseSelection = .first
    
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
            VStack(alignment: .leading, spacing: 10) {
                Text("Certificate of Vaccination")
                    .multilineTextAlignment(.leading)
                    .font(.custom("Avenir", size: 22).bold())
                    .foregroundColor(Color(.white))
                    .padding(.leading, 20)
                
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
                
                // MARK: QR Code and Certificate information
                List(firstDoseVaccModel.firstDoseData) { firstDoseData in
                    VStack {
                        HStack{
                            Image(uiImage: generateQRCode(from: " Name: \(fullName)\n Status: \(firstDoseData.vaccStatus)\n DOB: \(dob)\n ID: \(idNum)"))
                                .interpolation(.none)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 175, height: 175, alignment: .leading)
                                .padding(5)
                        }
                        
                        // MARK: Disclaimer
                        Text("Valid only with an identity document")
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 60, alignment: .center)
                            .font(.custom("Avenir", size: 12))
                            .multilineTextAlignment(.leading)
                            .lineLimit(10)
                    }.foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                }
                
                VStack {
                    
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
        let encryptedString = string.aesEncrypt(key: "CDJmG*CsYKULK68FcxWHZMEwc_LG") ?? ""
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
