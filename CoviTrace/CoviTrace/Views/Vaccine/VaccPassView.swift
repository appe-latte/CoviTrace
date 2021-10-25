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
    @State var lastName = ""
    @State var firstName = ""
    @State var vaccStatus = ""
    @State var dob = ""
    
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
    // MARK: for QR Code generation
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        ZStack {
            Background()
            VStack(alignment: .center, spacing: 10) {
                Text("Certificate of Vaccination")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 26).bold())
                    .foregroundColor(Color(.white))
                
                let fullName = authModel.user!.fName + " " + authModel.user!.lName
                let dob = authModel.user!.dob
                
                HStack {
                    // MARK: ID Number
                    Text(authModel.user!.patientNumber)
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
                
                // MARK: Disclaimer
                
                Text("This is to certify that the user's Covid-19 vaccination has been verified as legitimate and this certificate eligible for use as proof for the purpose of travel.")
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                    .font(.system(size: 13))
                    .multilineTextAlignment(.leading)
                    .lineLimit(6)
                    .foregroundColor(.white)
                
//                Spacer()
                
                // MARK: QR Code and Certificate information
                List(viewModel.results) { results in
                    VStack {
                        HStack{
                            Image(uiImage: generateQRCode(from: " Full Name: \(fullName)\n Date of Birth: \(dob)\n First Dosage Date: \(results.vaccStatus)\n Expiry: \(results.vaccExpiry)"))
                                .interpolation(.none)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 125, height: 125)
                                .padding(.top, 5)
                                .padding(.bottom, 5)
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
                                
                                // MARK: Vaccination Expiry
                                VStack(alignment: .leading) {
                                    Text("Expiry:")
                                        .font(.system(size: 15))
                                        .bold()
                                    HStack{
                                        Text(results.vaccExpiry)
                                            .font(.system(size: 15))
                                            .bold()
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    }
                                }
                            }
                        }
                    }.foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
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

struct VaccPassView_Previews: PreviewProvider {
    static var previews: some View {
        VaccPassView()
    }
}
