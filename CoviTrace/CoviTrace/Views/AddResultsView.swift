//
//  AddResultsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/02/2021.
//

import SwiftUI
import Firebase

struct AddResultsView: View {
    @State private var isPresented = true
    @State private var testRefNum = ""
    @State private var labRefNum = ""
    @State private var hospitalNum = ""
    @State private var testDate = Date()
    @State private var testResult = ""
    @State private var testLocation = ""
    @Environment(\.presentationMode) var presentationMode
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
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
                
                // MARK: Hospital Ref Number TextField
                SimpleTextField(text: $hospitalNum, placeholder: Text("Enter Hospital Number"))
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
                DatePicker(selection: $testDate, in: ...Date(), displayedComponents: .date) {
                    Text("Test / Vaccination Date")
                        .padding(.leading, 15)
                }
                .foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                .background(Color(.white).opacity(0.1))
                .cornerRadius(15)
                .font(.footnote)
                
                // MARK: Test Result TextField
                SimpleTextField(text: $testResult, placeholder: Text("Test Result"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading, 10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
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
        db.collection("results").document().setData(["Test Reference No.": testRefNum, "Lab Reference No.": labRefNum, "Hospital / Clinic No.": hospitalNum, "Test Location": testLocation, "Test Date": testDate, "Test Result": testResult])
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        AddResultsView()
    }
}
