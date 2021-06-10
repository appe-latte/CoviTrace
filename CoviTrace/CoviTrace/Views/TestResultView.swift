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
    @State var showSheetView = false
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
 
    var body: some View {
        ZStack
        {
            Background()
            VStack {
                VStack{
                    
                    // MARK: Upload Test Results sheet
                    Button(action: {
                        self.showSheetView.toggle()
                    }, label: {
                        Text("Upload Results")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(12)
                    .padding()
                    .sheet(isPresented: $showSheetView) {
                        AddResultsView()
                    }
                }
                .padding(5.0)
                .background(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                
                // MARK: Test Result Information
                VStack {
                    HStack{
                        Text("Previous Results")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                            .padding(5)
                        
                        Spacer()
                    }
                    Divider()
                    List(viewModel.results) { results in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(results.testDate)
                                    .font(.subheadline)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .bold()
                            }
                            HStack {
                                Text("Reference Number:")
                                    .font(.subheadline)
                                Spacer()
                                Text(results.testRefNum)
                                    .font(.subheadline)
                            }
                            HStack {
                                Text("Test Provider:")
                                    .font(.subheadline)
                                Spacer()
                                Text(results.testProvider)
                                    .font(.subheadline)
                            }
                            HStack {
                                Text("Test Result:")
                                    .font(.subheadline)
                                Spacer()
                                Text(results.testResult)
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            }
                            HStack {
                                Text("Verification Status:")
                                    .font(.subheadline)
                                Spacer()
                                Text(results.testVerified)
                                    .font(.subheadline)
                            }
                        }
                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                    .onAppear() {
                        self.viewModel.fetchData(id: authModel.userSession!.uid)
                    }
                }
            }.navigationBarTitle("Test Results", displayMode: .inline)
            

        }
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
