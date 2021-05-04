//
//  VaccinationCertView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/03/2021.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import Firebase

struct VaccCertView: View {
    @State private var lastName = "Bloggingson"
    @State private var firstName = "Joel"
    @State private var batchNum = "L620224"
    @State private var vaccDate = "09/02/2021"
    @State private var vaccCentre = "xPress Labs, Reading"
    @State private var vaccType = "Pfizer-BioNTech"
    @State private var firstDosageDate = "09/02/2021"
    @State private var secondDosageDate = "15/04/2021"
    @State var showSheetView = false
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor.init(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
    }
    
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
            // MARK: Vaccine Information
            Form {
                Section {
                    VStack(alignment: .leading){
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 300, height: 150)
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            //                            .shadow(color: Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255), radius: 2, x: 0.0, y: 0.0)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                        
                        // MARK: Vaccination "card"
                        
                        let fullName = firstName + " " + lastName
                        Text("Name: \(fullName)")
                        Text("Vaccine Make: \(vaccType)")
                        Text("First Dosage Date: \(firstDosageDate)")
                        Text("Vaccination Centre: \(vaccCentre)").multilineTextAlignment(.leading)
                        Spacer()
                        Image(uiImage: generateQRCode(from: " First Name: \(firstName)\n Last Name: \(lastName)\n Batch Number: \(batchNum)\n Vaccination Date: \(vaccDate)\n Vaccine: \(vaccType)\n First Dose: \(firstDosageDate)\n Second Dose: \(secondDosageDate)\n Location: \(vaccCentre)"))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .padding(10)
                    }.font(.body)
                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                }
            }.foregroundColor(.white)
            Spacer()
            Spacer()
        }
        .navigationBarTitle("Vaccination Information", displayMode: .inline)
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
