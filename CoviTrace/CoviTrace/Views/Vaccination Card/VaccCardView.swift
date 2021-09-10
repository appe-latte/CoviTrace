//
//  VaccCardView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/06/2021.
//

import SwiftUI
import Firebase

struct VaccCardView: View {
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var firstDosebatchNum = ""
    @State private var secondDosebatchNum = ""
    @State private var firstDoseVaccType = ""
    @State private var secondDoseVaccType = ""
    @State private var firstDoseDate = ""
    @State private var secondDoseDate = ""
    @State private var vaccStatus = ""
    @State private var vaccExpiry = ""
    @State private var firstDosageLocation = ""
    @State private var secondDosageLocation = ""
    @State private var firstDoseVaccProvider = ""
    @State private var secondDoseVaccProvider = ""
    @State var showSheetView = false
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        UITableViewCell.appearance().backgroundColor = UIColor(Color(.white))
    }
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                TabView() {
                    VaccCertView()
                    FirstDoseVaccineView()
                    SecondDoseVaccineView()
                    
                }.tabViewStyle(PageTabViewStyle())
            }
        }
    }
}

struct VaccCardView_Previews: PreviewProvider {
    static var previews: some View {
        VaccCardView()
    }
}
