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
    @State private var testDate = ""
    @State private var testResult = ""
    @State private var testLocation = ""
    @State private var userId = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var authModel = AuthViewModel()
    
    // MARK: Results
    var results = ["Select Result", "Negative", "Positive"]
    @State private var selectedResult = ""
    @State private var selectedDate = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter
    }
    
    @State private var birthDate = Date()
    
    var body: some View {
        ZStack{
            Background()
            VStack{
                // MARK: Test Reference Number TextField
                SimpleTextField(text: $testRefNum, placeholder: Text("Enter Test Reference number"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Lab Ref Number TextField
                SimpleTextField(text: $labRefNum, placeholder: Text("Enter Lab Reference Number"))
                    //                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Test Location TextField
                SimpleTextField(text: $testLocation, placeholder: Text("Enter Test Location"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Test Date TextField
                DatePicker(selection: $selectedDate, in: ...Date(), displayedComponents: .date) {
                    Text("Select a date")
                        .padding(.leading)
                        .foregroundColor(Color(.white)).font(.system(size: 14))
                }.foregroundColor(Color(.white))
                
                
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                .background(Color(.white).opacity(0.1)).font(.system(size: 14))
                .cornerRadius(15)
                
                // MARK: Test Result Picker
                
                VStack {
                    Picker("Test Result", selection: $selectedResult) {
                        ForEach(results, id: \.self) {
                            Text($0)
                        }
                    }
                }
                .foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                .background(Color(.white).opacity(0.1))
                .cornerRadius(15)
                .font(.footnote)
                
                // MARK: "Log Results" Button
                Button(action: {
                    upload_data()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("LOG RESULTS")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading,10)
                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                .cornerRadius(30)
                .padding(.top, 2)
                
                Spacer()
            }
            .padding(.top, 15)
        }.navigationBarHidden(false)
    }
    
    // MARK: Upload to "Results" DB
    func upload_data(){
        let db = Firestore.firestore()
        let date = dateFormatter.string(from: selectedDate)
        db.collection("results").document().setData(["userId": authModel.userSession!.uid, "test_ref_num": testRefNum, "lab_ref_num": labRefNum, "test_location": testLocation, "date": date, "test_result": selectedResult])
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        AddResultsView()
    }
}
