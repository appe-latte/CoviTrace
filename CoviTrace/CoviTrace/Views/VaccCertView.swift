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
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var batchNum = ""
    @State private var vaccDate = ""
    @State private var vaccCentre = ""
    @State private var vaccType = ""
    @State private var firstDosageDate = ""
    @State private var secondDosageDate = ""
    @State private var vaccStatus = ""
    @State private var vaccExpiry = ""
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
                    List(viewModel.results) { results in
                        VStack(alignment: .center){
                            Image(systemName: "person.crop.circle.fill")
                                .data(url: URL(string: "\(authModel.user!.profileImageUrl)")!)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 300, height: 150)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(.top, 5)
                                .padding(.bottom, 5)
                            
                            // MARK: Vaccination "card"
                            
                            let fullName = authModel.user!.fName + " " + authModel.user!.lName
                            Text("Name: \(fullName)")
                                .bold()
                                .font(.body)
                            Text("Status: \(results.vaccStatus)")
                                .bold()
                                .font(.body)
                            Spacer()
                            Image(uiImage: generateQRCode(from: " Full Name: \(fullName)\n First Dosage Date: \(results.firstDoseDate)\n First Dose Batch No.: \(results.firstDosebatchNum)\n First Dosage Make: \(results.firstDoseVaccType) \n Second Dosage Date: \(results.secondDoseDate)\n Second Dosage Batch No.: \(results.secondDosebatchNum)\n Second Dosage Make: \(results.secondDoseVaccType)\n Location: \(results.vaccCentre)"))
                                
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                                .padding(10)
                            Spacer()
                            Text("Valid Until: \(results.vaccExpiry)")
                                .bold()
//                                .padding(.leading, 75)
                        }.font(.body)
                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                }
            }.foregroundColor(.white)
            .onAppear() {
                self.viewModel.fetchData(id: authModel.userSession!.uid)
            }
            Spacer()
            Spacer()
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

struct VaccinationCertView_Previews: PreviewProvider {
    static var previews: some View {
        VaccCertView()
    }
}
