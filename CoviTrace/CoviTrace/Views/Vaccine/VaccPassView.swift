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

struct VaccPassView: View {
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var vaccStatus = ""
    @State private var dob = ""
    @State private var firstDoseDate = ""
    @State private var secondDoseDate = ""
    
    @ObservedObject private var viewModel = VaccinationViewModel()
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
            Background()
            VStack(alignment: .center, spacing: 10) {
                Text("Certificate of Vaccination")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 26).bold())
                    .foregroundColor(Color(.white))
                
                let fullName = authModel.user!.firstName + " " + authModel.user!.lastName
                let cellNum = authModel.user!.cellNum
                let checkDate = Date()
//                let dob = authModel.user!.dob
//                let idNumber = authModel.user!.idNumber
                
                HStack {
                    // MARK: ID Number
                    Text(authModel.user!.idNumber)
                        .font(.system(size: 15))
                        .bold()
                        .foregroundColor(Color(.white))
                    
                    Spacer()
                    
                    // MARK: User's full name
                    Text(fullName)
                        .font(.system(size: 15))
                        .bold()
                        .foregroundColor(Color(.white))
                    
                }.padding(.horizontal, 50)
                
                // MARK: QR Code and Certificate information
                List(viewModel.results) { results in
                    VStack {
                        HStack{
                            Image(uiImage: generateQRCode(from: " Full Name: \(fullName)\n Status: \(results.vaccStatus)\n Cellphone: \(cellNum)\n Date: \(checkDate)"))
                                .interpolation(.none)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 125, height: 125)
                                .padding(.vertical, 5)
                                .padding(.trailing, 5)
                            
                            // MARK: User Details
                            VStack(alignment: .leading, spacing: 5) {
                                VStack(alignment: .leading){
                                    Text("Date of Birth:")
                                        .font(.system(size: 15))
                                        .bold()
                                    Text(authModel.user!.dob)
                                        .font(.system(size: 15))
                                        .bold()
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                }
                                
                                // MARK: Vaccination Status
                                VStack(alignment: .leading) {
                                    Text("Vaccination:")
                                        .font(.system(size: 15))
                                        .bold()
                                    HStack{
                                        Text(results.vaccStatus)
                                            .font(.system(size: 15))
                                            .bold()
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    }
                                }
                                
                                // MARK: Vaccination Country
                                VStack(alignment: .leading) {
                                    Text("Country:")
                                        .font(.system(size: 15))
                                        .bold()
                                    HStack{
                                        Text(authModel.user!.regCountry)
                                            .font(.system(size: 15))
                                            .bold()
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    }
                                }
                            }
                        }
                        // MARK: Disclaimer
                        Text("This is to certify that the user's Covid-19 vaccination has been verified as legitimate and this certificate eligible for use as proof for the purpose of travel.")
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 60, alignment: .center)
                            .font(.system(size: 13))
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
                self.viewModel.fetchData(id: authModel.userSession!.uid)
                
            }.padding(.top, 20)
        }.navigationBarTitle("Vaccination Pass")
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
    // MARK: Function for creating QR code
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
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
