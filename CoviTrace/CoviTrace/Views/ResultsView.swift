//
//  ResultsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/02/2021.
//

import SwiftUI

struct ResultsView: View {
    @State var testRefNum = ""
    @State var testCentre = ""
    @State var testDate = ""
    @State var testResult = ""
    @ObservedObject private var resultsViewModel = testResultViewModel()
    
    var body: some View {
        ZStack{
            ResultsTopView()
            
            VStack{
                // MARK: Test Reference Number
                SimpleTextField(text: $testRefNum, placeholder: Text("Enter Test Reference number"))
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Test Centre
                SimpleTextField(text: $testCentre, placeholder: Text("Enter Test Centre"))
//                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK:
                HStack{
                    // MARK: Test Date
                    SimpleTextField(text: $testDate, placeholder: Text("Test Date"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(15)
                    
                    // MARK: Test Result
                    SimpleTextField(text: $testResult, placeholder: Text("Test Result"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: 0, maxWidth: 180, minHeight: 0, maxHeight: 50).padding(.leading, 10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(15)
                }
                // MARK: "Upload Certificate" Button
                Button(action: {
                   
                }, label: {
                    Text("UPLOAD CERTIFICATE")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading,10)
                .background(Color(red: 246 / 255, green: 245 / 255, blue: 243 / 255))
                .cornerRadius(30)
                
                // MARK: "Check-In" Button
                Button(action: {
                   
                }, label: {
                    Text("LOG RESULTS")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading,10)
                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                .cornerRadius(30)
                .padding(.top, 2)
//                    Spacer()
            }.frame(minHeight: 0, maxHeight: 300, alignment: .top)
            
//        }
        }.navigationBarTitle("Test Results")
        
        VStack{
            ResultsListView()
        }.frame(minHeight: 0, maxHeight: 400, alignment: .bottom)
    }
}
struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
