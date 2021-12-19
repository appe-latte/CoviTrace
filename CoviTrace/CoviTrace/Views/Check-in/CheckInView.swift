//
//  CheckInView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 12/02/2021.
//

import SwiftUI
import Combine
import Firebase
import CoreLocation
import FirebaseFirestore

struct CheckInView: View {
    let locationFetch = LocationFetch()
    
    @EnvironmentObject var viewModel : AuthViewModel
    @ObservedObject var resultsViewModel = ResultsViewModel()
    @ObservedObject private var vaccModel = FirstDoseVaccViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    List(resultsViewModel.results1) { results in
                        HStack {
                            Text(results.date).font(.custom("Avenir", size: 13))
                                .fontWeight(.semibold)
                                .padding(12)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            Text(results.address)
                                .font(.custom("Avenir", size: 13))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        }
                    }.onAppear() {
                        self.resultsViewModel.fetchLocationData(id: viewModel.userSession!.uid)
                    }
                }.background(bgWhite())
            }
        }.background(bgPurple())
            .navigationBarTitle("Previous Check-ins", displayMode: .inline)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
