//
//  VaccCardView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/06/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct VaccCardView: View {
    @State private var showSheetView = false
    @State private var selectDose: doseSelection = .first
    
    @ObservedObject private var viewModel = FirstDoseVaccViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var boosterModel = BoosterShotViewModel()
    
    init() {
        //        UITableView.appearance().backgroundColor = UIColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        UITableViewCell.appearance().backgroundColor = UIColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
    }
    
    var body: some View {
        ZStack {
            VStack {
                
                // MARK: Segmented Control for Dose Selection
                Picker("Dose Selection:", selection: $selectDose) {
                    ForEach(doseSelection.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                    
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 5)
                    .padding(.top, 10)
                doseSelectionView(selectedDose: selectDose)
            }
        }.navigationBarTitle("Vaccination Information", displayMode: .inline)
    }
}
