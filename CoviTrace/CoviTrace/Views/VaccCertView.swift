//
//  VaccinationCertView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/03/2021.
//

import SwiftUI
import Firebase
import CoreImage.CIFilterBuiltins

struct VaccCertView: View {
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var firstDosebatchNum = ""
    @State private var secondDosebatchNum = ""
    @State private var firstDoseVaccType = ""
    @State private var secondDoseVaccType = ""
    @State private var firstDoseDate = ""
    @State private var secondDoseDate = ""
    @State private var vaccStatus = ""
    @State private var vaccExpiry = ""
    @State private var firstDosageLocation = ""
    @State private var secondDosageLocation = ""
    @State private var firstDoseVaccProvider = ""
    @State private var secondDoseVaccProvider = ""
    @State var showSheetView = false
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor.white
    }
    
    var body: some View {
        
        ZStack
        {
            // MARK: BACKGROUND COLOUR CODE:
            Background()
            
            VStack{
                VStack {
                    Text("Scan the QR code below for information")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                    VStack {
                        List(viewModel.results) { results in
                            VStack {
                                
                                let fullName = authModel.user!.fName + " " + authModel.user!.lName
                                Spacer()
                                Image(uiImage: generateQRCode(from: " Full Name: \(fullName)\n First Dosage Date: \(results.firstDoseDate)\n First Dose Batch No.: \(results.firstDosebatchNum)\n First Dosage Make: \(results.firstDoseVaccType) \n Issued By: \(results.firstDosageLocation)\n Provider: \(results.firstDoseVaccProvider)\n Second Dosage Date: \(results.secondDoseDate)\n Second Dosage Batch No.: \(results.secondDosebatchNum)\n Second Dosage Make: \(results.secondDoseVaccType)\n Issued By: \(results.secondDosageLocation)\n Provider: \(results.secondDoseVaccProvider)\n Expiry: \(results.vaccExpiry)"))
                                    .interpolation(.none)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 300, height: 300)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                                    .padding(.trailing, 5)
                            }.font(.body)
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        }
                    }
                    .frame(width: 325, height: 325)
                    .background(Color(.white))
                    .cornerRadius(15)
//                    .padding(5)
                }.onAppear() {
                    self.viewModel.fetchData(id: authModel.userSession!.uid)
                }
            }
        }
        .navigationBarTitle("Vaccination Card", displayMode: .inline)
    }
    
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
