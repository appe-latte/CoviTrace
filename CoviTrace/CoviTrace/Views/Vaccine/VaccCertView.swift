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
    @State var lastName = ""
    @State var firstName = ""
    @State var firstDosebatchNum = ""
    @State var secondDosebatchNum = ""
    @State var firstDoseVaccType = ""
    @State var secondDoseVaccType = ""
    @State var firstDoseDate = ""
    @State var secondDoseDate = ""
    @State var vaccStatus = ""
    @State var vaccExpiry = ""
    @State var firstDosageLocation = ""
    @State var secondDosageLocation = ""
    @State var firstDoseVaccProvider = ""
    @State var secondDoseVaccProvider = ""
    @State var testName = ""
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
            VStack{
                VStack {
                    VStack{
                        
                        // MARK: Vaccination Information
                        Button(action: {
                            self.showSheetView.toggle()
                        }, label: {
                            HStack {
                                Image(systemName: "info.circle")
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            Text("Vaccination Information")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            }
                        }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding()
                        .sheet(isPresented: $showSheetView) {
                            VaccCardView()
                        }
                    }
                    .background(Color.white)
                    
                    Text("Certificate of Vaccination")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 26).bold())
                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                    
                    let fullName = authModel.user!.fName + " " + authModel.user!.lName
                    
                    // MARK: User Name
                    Text(fullName)
                        .font(.system(size: 15))
                        .bold()
                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                    
                    VStack {
                        List(viewModel.results) { results in
                            VStack {
                                Text("This is to certify that the user's Covid-19 vaccination has been verified as legitimate and this certificate eligible for use as proof for the purpose of travel.")
                                    .frame(width: 300, height: 150)
                                
                                HStack{
                                    Image(uiImage: generateQRCode(from: " Full Name: \(fullName)\n First Dosage Date: \(results.firstDoseDate)\n First Dose Batch No.: \(results.firstDosebatchNum)\n First Dosage Make: \(results.firstDoseVaccType) \n Issued By: \(results.firstDosageLocation)\n Provider: \(results.firstDoseVaccProvider)\n Second Dosage Date: \(results.secondDoseDate)\n Second Dosage Batch No.: \(results.secondDosebatchNum)\n Second Dosage Make: \(results.secondDoseVaccType)\n Issued By: \(results.secondDosageLocation)\n Provider: \(results.secondDoseVaccProvider)\n Expiry: \(results.vaccExpiry)"))
                                        .interpolation(.none)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 125, height: 125)
                                        .padding(.top, 5)
                                        .padding(.bottom, 5)
                                        .padding(.trailing, 5)
                                    
                                    // MARK: User Details
                                    VStack(alignment: .leading) {
//                                        Text(testName)
//                                            .font(.system(size: 15))
//                                            .bold()
                                        VStack(alignment: .leading){
                                            Text("Profile Status:")
                                                .font(.system(size: 15))
                                                .bold()
                                            Text(authModel.user!.verified)
                                                .font(.system(size: 15))
                                                .bold()
                                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        }
                                        .padding(2.0)
                                        
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
                                        }.padding(2.0)
                                        
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
                                
                                Spacer()
                                
                                VStack(alignment: .center){
                                    Text("Vaccination Information verified by:")
                                        .font(.system(size: 15))
                                    Spacer()
                                    HStack {
                                    Text("Data Protection Officer")
                                        .font(.system(size: 13))
                                        .fontWeight(.semibold)
                                        Text("| Covitrace Ltd.")
                                            .font(.system(size: 14))
                                    }
                                    HStack {
                                    Image("ico-logo")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 50, height: 40)
                                        .scaledToFit()
                                        Text("Registration Number: ZB074608")
                                            .font(.system(size: 13))
                                    }
                                }
                            }.foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            Spacer()
                        }
                        Spacer()
                    }.multilineTextAlignment(.leading)
                    .font(.system(size: 18))
                    .lineLimit(6)
                    .frame(width: 350, height: 400)
                    .background(Color(.white))
                }.onAppear() {
                    self.viewModel.fetchData(id: authModel.userSession!.uid)
                }
            }
            Spacer()
            
        }
        Spacer()
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
