//
//  TestResultView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/03/2021.
//

import SwiftUI
import Firebase

struct TestResultView: View {
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var dob = ""
    @State private var testRefNum = ""
    @State private var labRefNum = ""
    @State private var hospitalNum = ""
    @State private var testDate = Date()
    @State private var testResult = ""
    @State private var testLocation = ""
    @State var showSheetView = false
    
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
            
        }
    }
}

struct TestResultView_Previews: PreviewProvider {
    static var previews: some View {
        TestResultView()
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
