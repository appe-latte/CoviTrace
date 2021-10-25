//
//  TestResultView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/03/2021.
//

import SwiftUI
import Firebase

struct TestResultView: View {
    @State private var testRefNum = ""
    @State private var testProvider = ""
    @State private var testDate = ""
    @State private var testResult = ""
    @State private var testLocation = ""
    @State private var testVerified = ""
    @State var showTestCertView = false
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
    var body: some View {
        ZStack
        {
            Background()
            VStack {
                VStack {
                    List(viewModel.results) { results in
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                
                                // MARK: Test Date
                                HStack {
                                    Text(results.testDate)
                                        .font(.subheadline)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        .bold()
                                }
                                
                                // MARK: Test Reference Number
                                HStack {
                                    Text("Reference Number:")
                                        .font(.subheadline)
                                    Spacer()
                                    Text(results.testRefNum)
                                        .font(.subheadline)
                                }
                                
                                // MARK: Test Provider
                                HStack {
                                    Text("Test Provider:")
                                        .font(.subheadline)
                                    Spacer()
                                    Text(results.testProvider)
                                        .font(.subheadline)
                                }
                                
                                // MARK: Test Result
                                HStack {
                                    Text("Test Result:")
                                        .font(.subheadline)
                                    Spacer()
                                    Text(results.testResult)
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                                
                                // MARK: Test Result Verification Status
                                HStack {
                                    Text("Verification Status:")
                                        .font(.subheadline)
                                    Spacer()
                                    Text(results.testVerified)
                                        .font(.subheadline)
                                }.padding(.bottom, 5)
                                
                                HStack {
                                    NavigationLink(
                                        destination: ShowTestCertView()){
                                            
                                        }.opacity(0) // opacity hides the chevron that comes with the NavigationLink
                                }
                            }
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            
                           Image(systemName: "chevron.right")
                                .foregroundColor(Color.gray)
                                .padding(.leading, 5)
                            
                        }
                    }
                    .onAppear() {
                        self.viewModel.fetchData(id: authModel.userSession!.uid)
                    }
                }
            }.navigationBarTitle("Saved Test Results", displayMode: .inline)
            
            
        }
    }
}
