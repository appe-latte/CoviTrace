//
//  CovidStatsViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 12/05/2021.
//

import SwiftUI

class CovidStatsViewModel: ObservableObject {
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject var covidFetch = CovidFetchRequest()
    

}
