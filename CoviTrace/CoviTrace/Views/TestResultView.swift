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
            
            // MARK: Test Result Information
            NavigationView {
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
                    self.viewModel.fetchData()
                }
            }
        }
    }
}

//struct TestResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestResultView()
//    }
//}

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
