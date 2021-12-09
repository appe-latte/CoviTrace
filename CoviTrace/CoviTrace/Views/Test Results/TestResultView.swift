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
        ZStack {
            bgPurple()
            
            VStack {
                VStack {
                    List(viewModel.results) { results in
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                
                                // MARK: Test Date
                                HStack {
                                    Text(results.testDate)
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        .bold()
                                }
                                
                                // MARK: Test Reference Number
                                HStack {
                                    Text("Reference Number:")
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text(results.testRefNum)
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.semibold)
                                }
                                
                                // MARK: Test Provider
                                HStack {
                                    Text("Test Provider:")
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text(results.testProvider)
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.semibold)
                                }
                                
                                // MARK: Test Result
                                HStack {
                                    Text("Test Result:")
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text(results.testResult)
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                }
                                
                                // MARK: Test Result Verification Status
                                HStack {
                                    Text("Verification Status:")
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text(results.testVerified)
                                        .font(.custom("Avenir", size: 14))
                                        .fontWeight(.semibold)
                                }.padding(.bottom, 5)
                                
                                HStack {
                                    NavigationLink(
                                        destination: ShowTestCertView(testResult: results)){
                                            
                                        }.opacity(0) // opacity hides the chevron that comes with the NavigationLink
                                }
                            }
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            
                            Image("arrow-right")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(1)
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
