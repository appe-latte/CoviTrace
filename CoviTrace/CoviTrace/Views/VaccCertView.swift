//
//  VaccinationCertView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/03/2021.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct VaccCertView: View {
    @State private var lastName = "Bloggingson"
    @State private var firstName = "Joel"
    @State private var batchNum = "L620224"
    @State private var vaccDate = "02/02/2020"
    @State private var vaccCentre = "xPress Labs, Reading"
    @State private var vaccType = "Pfizer-BioNTech"
    @State private var firstDosageDate = "02/02/2020"
    @State private var secondDosageDate = ""
    @State var showSheetView = false
    @EnvironmentObject var viewModel : AuthViewModel
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        
        ZStack
        {
            // MARK: BACKGROUND COLOUR CODE:
            Background()
                .navigationBarItems(trailing:
                                        Button(action: {
                                            self.showSheetView.toggle()
                                        }) {
                                            Image(systemName: "plus.circle.fill")
                                                .foregroundColor(.white)
                                                .font(.title3)
                                        }.sheet(isPresented: $showSheetView) {
                                            AddVaccinationDataView()
                                        }
                )
            // MARK: Test Result Info
            Form {
                Section(header: Text("Vaccination Information:")){
                    VStack(alignment: .leading){
                        Text("Name: \(firstName)" + " " + "\(lastName)")
                        Text("Vaccine: \(vaccType)")
                        Text("1st Dose: \(firstDosageDate)")
                        Text("2nd Dose: \(secondDosageDate)")
                        Text("Location: \(vaccCentre)")
                        Spacer()
                        Image(uiImage: generateQRCode(from: " First Name: \(firstName)\n Last Name: \(lastName)\n Batch Number: \(batchNum)\n Vaccination Date: \(vaccDate)\n Vaccine: \(vaccType)\n First Dose: \(firstDosageDate)\n Second Dose: \(secondDosageDate)\n Location: \(vaccCentre)"))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .padding(10)
                    }.font(.title3)
                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                }
            }.foregroundColor(.white)
            Spacer()
            Spacer()
        }
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

struct VaccinationCertView_Previews: PreviewProvider {
    static var previews: some View {
        VaccCertView()
    }
}
