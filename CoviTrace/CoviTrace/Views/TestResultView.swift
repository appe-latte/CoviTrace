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
    @State private var labRefNum = ""
    @State private var testDate = ""
    @State private var testResult = ""
    @State private var testLocation = ""
    @State var showSheetView = false
    
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
    var body: some View {
        ZStack
        {
            VStack {
                // MARK: BACKGROUND COLOUR CODE:
                //            Background()
                //                .navigationBarItems(trailing:
                //                                        Button(action: {
                //                                            self.showSheetView.toggle()
                //                                        }) {
                //                                            Image(systemName: "plus.circle.fill")
                //                                                .foregroundColor(.white)
                //                                                .font(.title3)
                //                                        }.sheet(isPresented: $showSheetView) {
                //                                            AddResultsView()
                //                                        }
                //                )
                
                VStack{
                    
                    // MARK: "Check-In" Button
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
                //            NavigationView {
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
                                Text(results.testRefNum)
                                    .font(.subheadline)
                                Spacer()
                                Text(results.testResult)
                                    .font(.subheadline)
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .bold()
                            }
                            Text(results.testLocation)
                                .font(.subheadline)
                        }
                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                    .onAppear() {
                        self.viewModel.fetchData(id: authModel.userSession!.uid)
                    }
                }
                
                //            }
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
