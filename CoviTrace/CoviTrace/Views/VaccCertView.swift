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
            VStack {
                VStack{
                    
                    // MARK: "Vaccination" upload button
                    Button(action: {
                        self.showSheetView.toggle()
                    }, label: {
                        Text("Upload Vaccine Details")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(12)
                    .padding()
                    .sheet(isPresented: $showSheetView) {
                        AddVaccinationDataView()
                    }
                    
                    Text("* Email results to: vaccine@getcovitcace.com for verification.")
                        .foregroundColor(.white)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                }
                .padding(5.0)
                .padding(.top, 50)
                .background(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                
                // MARK: Vaccine Information
                VStack(alignment: .leading){
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 300, height: 150)
                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
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
                .padding()
                //                }
                Spacer()
                Spacer()
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

struct VaccinationCertView_Previews: PreviewProvider {
    static var previews: some View {
        VaccCertView()
    }
}
