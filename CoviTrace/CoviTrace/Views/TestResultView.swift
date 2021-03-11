//
//  TestResultView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/03/2021.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct TestResultView: View {
    @State private var lastName = "Bloggingson"
    @State private var firstName = "Joel"
    @State private var dob = "01/01/90"
    @State private var testRefNum = "0224"
    @State private var labRefNum = "40T019961"
    @State private var hospitalNum = ""
    @State private var testDate = "15/12/2020"
    @State private var testResult = "Negative"
    @State private var testLocation = "xPress Labs, Reading"
    @State var showSheetView = false
    
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
                                            AddResultsView()
                                        }
                )
            // MARK: Test Result Info
            Form {
                Section(header: Text("Test Information")){
                    VStack(alignment: .leading){
                        Text("Name: \(firstName)" + " " + "\(lastName)")
                        Text("DOB: \(dob)")
                        Text("Reference #: \(testRefNum)")
                        Text("Location: \(testLocation)")
                        Text("Result: \(testResult)")
                        Spacer()
                    }.font(.title3)
                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                }
                Section {
                    VStack(alignment: .center){
                        Image(uiImage: generateQRCode(from: "\(firstName)\n\(lastName)\n\(dob)\n\(testRefNum)\n\(labRefNum)\n\(hospitalNum)\n\(testDate)\n\(testResult)"))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .padding(10)
                    }
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

struct TestResultView_Previews: PreviewProvider {
    static var previews: some View {
        TestResultView()
    }
}

struct SheetView: View {
    @Binding var showSheetView: Bool

    var body: some View {
        NavigationView {
            Text("Test Results")
            .navigationBarTitle(Text("Add Test Result"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    print("Dismissing sheet view...")
                    self.showSheetView = false
                }) {
                    Text("Done").bold()
                })
        }
    }
}
