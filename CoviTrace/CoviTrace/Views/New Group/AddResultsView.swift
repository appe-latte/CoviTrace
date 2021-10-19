//
//  AddResultsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/02/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct AddResultsView: View {
    @State private var isPresented = true
    @State private var testRefNum = ""
    @State private var labRefNum = ""
    @State private var testDate = Date()
    @State private var testProvider = ""
    @State private var userId = ""
    @State private var testVerified = "pending"
    @State private var resultUploadDate = Date() // Logs the date that the results are uploaded onto the system
    @State private var specimenNum = ""
    @State private var testResult = ""
    let selectResult = ["NEGATIVE", "POSITIVE"]
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var authModel = AuthViewModel()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter
    }
    
    var body: some View {
        ZStack{
            Background()
            VStack{
                
                Text("Add PCR / Antigen Test Results")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                // MARK: Test Reference Number TextField
                SimpleTextField(text: $testRefNum, placeholder: Text("Enter Test Reference number"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Lab Ref Number TextField
                SimpleTextField(text: $labRefNum, placeholder: Text("Enter Lab Reference Number"))
                //                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Specimen Number
                SimpleTextField(text: $specimenNum, placeholder: Text("Enter Specimen Number"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Test Location TextField
                SimpleTextField(text: $testProvider, placeholder: Text("Enter Test Provider"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Test Date Picker
                DatePicker(selection: $testDate, in: ...Date(), displayedComponents: .date) {
                    Text("Choose Date:")
                        .padding(.leading)
                        .foregroundColor(Color(.white)).font(.system(size: 14))
                }.foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1)).font(.system(size: 14))
                    .cornerRadius(15)
                
                // MARK: Test Result Picker
                HStack {
                    Text("Choose Result:")
                        .padding(.leading)
                        .foregroundColor(Color(.white)).font(.system(size: 14))
                        
                    Spacer()
                    
                    Picker("Result", selection: $testResult) {
                        ForEach(selectResult, id: \.self) {
                            Text($0)
                        }
                    }
                }.padding(.trailing, 50)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Upload Test Certificate
                Button(action: {
                    // add code to upload certificate
                }, label: {
                    HStack {
                        Text("Upload Test Certificate")
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .fontWeight(.semibold)
                            .font(.subheadline)
                            .padding(.trailing, 10)
                    }
                    
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.top, 2)
                
                // MARK: "Log Results" Button
                Button(action: {
                    upload_data()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Text("SUBMIT")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(10)
                    .padding(.top, 2)
                
                Spacer()
            }
            .padding(.top, 15)
        }.navigationBarHidden(false)
    }
    
    // MARK: Upload to "Results" DB
    func upload_data(){
        let db = Firestore.firestore()
        let date = dateFormatter.string(from: testDate)
        db.collection("results").document().setData(["userId": authModel.userSession!.uid, "test_ref_num": testRefNum, "lab_ref_num": labRefNum, "test_provider": testProvider, "date": date, "test_result": testResult, "test_verified": testVerified, "result_upload_date": resultUploadDate, "specimen_num": specimenNum])
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        AddResultsView()
    }
}
