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
    //    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //    @ObservedObject private var viewModel = ResultsViewModel()
    //    @ObservedObject private var authModel = AuthViewModel()
    @EnvironmentObject var viewModel : AuthViewModel
    @ObservedObject var resultsViewModel = ResultsViewModel()
    @ObservedObject private var vaccModel = VaccinationViewModel()
    
    var body: some View {
        ZStack{
            Background()
            VStack(){
                VStack {
                    List(resultsViewModel.results1) { results in
                        HStack {
                            Text(results.date).font(.subheadline).padding(12)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            Text(results.address)
                                .font(.subheadline)
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        }
                    }.onAppear() {
                        //                        self.viewModel.fetchLocationData(id: authModel.userSession!.uid)
                        self.resultsViewModel.fetchLocationData(id: viewModel.userSession!.uid)
                    }
                }.background(Color.white)
            }
        }.navigationBarTitle("Previous Check-ins", displayMode: .inline)
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView()
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
