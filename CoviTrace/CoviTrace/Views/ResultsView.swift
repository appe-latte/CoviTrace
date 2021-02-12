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
    
    var body: some View {
        ZStack{
            ResultsTopView()
            VStack{
                // MARK: Test Reference Number
                CustomTextField(text: $testRefNum, placeholder: Text("Enter Test Reference number"), imageName: "person")
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading, 15)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                    .textContentType(.name)
                    .keyboardType(.default)
                
                // MARK: Test Centre
                CustomTextField(text: $testCentre, placeholder: Text("Enter Test Centre"), imageName: "person")
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading, 15)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                    .textContentType(.name)
                    .keyboardType(.default)
                
                // MARK:
                HStack{
                    // MARK: Test Date
                    CustomTextField(text: $testDate, placeholder: Text("Test Date"), imageName: "calendar")
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 50).padding(.leading, 15)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(15)
                        .textContentType(.name)
                        .keyboardType(.default)
                    
                    // MARK: Test Result
                    CustomTextField(text: $testResult, placeholder: Text("Test Result"), imageName: "calendar")
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(minWidth: 0, maxWidth: 180, minHeight: 0, maxHeight: 50).padding(.leading, 15)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(15)
                        .textContentType(.name)
                        .keyboardType(.default)
                }
                // MARK: "Upload Certificate" Button
                Button(action: {
                   
                }, label: {
                    Text("Upload Certificate")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center)
                .background(Color(red: 246 / 255, green: 245 / 255, blue: 243 / 255))
                .cornerRadius(15)
                
                
                // MARK: "Check-In" Button
                Button(action: {
                   
                }, label: {
                    Text("Log Results")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center)
                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                .cornerRadius(15)
                .padding(.top, 2)
    
                    Spacer()
            }
            
            
        }.navigationBarTitle("Test Results")
    }
}
struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
