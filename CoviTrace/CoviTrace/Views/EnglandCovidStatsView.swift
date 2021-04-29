//
//  EnglandCovidStatsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 28/04/2021.
//

import SwiftUI
import CoreLocation
import Firebase
import FirebaseFirestore

struct EnglandCovidStatsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject var covidFetch = CovidFetchRequest()
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.init(red: 83 / 255, green: 82 / 255, blue: 116 / 255, alpha: 1.0)
        navBarAppearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        navBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().standardAppearance = navBarAppearance
    }
    
    var body: some View {
        VStack{
            VStack(){
                VStack {
                    Section() {
                        List(covidFetch.covidDataEngland) { results in
                            VStack {
                                HStack{
                                    Text("Date: ")
                                    Spacer()
                                    Text( "\(results.date!)")
                                }
                                HStack{
                                    Text("Area: ")
                                    Spacer()
                                    Text( "\(results.areaName!)")
                                }
                                HStack{
                                    Text("New Cases: ")
                                    Spacer()
                                    Text( "\(results.newCasesByPublishDate!)")
                                }
                                HStack{
                                    Text("Total Cases: ")
                                    Spacer()
                                    Text( "\(results.cumCasesByPublishDate!)")
                                }
                                HStack{
                                    Text("Recent Deaths: ")
                                    Spacer()
                                    Text( "\(results.newDeathsByDeathDate!)")
                                }
                                HStack{
                                    Text("Total Deaths: ")
                                    Spacer()
                                    Text( "\(results.cumDeathsByDeathDate!)")
                                }
                            }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        }.onAppear() {
                            self.covidFetch.getCovidDataEngland()
                        }
                    }.foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                    
                }.background(Color.white)
            }
        }.navigationBarTitle("England Covid Statistics", displayMode: .inline)
    }
}

struct EnglandCovidStatsView_Previews: PreviewProvider {
    static var previews: some View {
        EnglandCovidStatsView()
    }
}

