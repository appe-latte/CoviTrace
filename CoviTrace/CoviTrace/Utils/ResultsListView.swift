//
//  ResultsList.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/02/2021.
//

import SwiftUI

struct ResultsListView: View {
    @ObservedObject private var resultsViewModel = testResultViewModel()
    
    var body: some View {
        // MARK: Results list
        NavigationView {
            List(resultsViewModel.results) { result in
                HStack {
                    Text(result.refNum)
                    Text(result.testCentre)
                    Text(result.testDate)
                    Text(result.testResult)
                }
            }
        }.onAppear() {
            self.resultsViewModel.fetchData()
        }
    }
}

struct ResultsList_Previews: PreviewProvider {
    static var previews: some View {
        ResultsListView()
    }
}
