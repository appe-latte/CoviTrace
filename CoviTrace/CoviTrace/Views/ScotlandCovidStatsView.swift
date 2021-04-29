//
//  ScotlandCovidStatsView.swift
//  CoviTrace
//
//  Created by q on 20/04/21.
//

import SwiftUI
import CoreLocation
import Firebase
import FirebaseFirestore

struct ScotlandCovidStatsView: View {
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
                        List(covidFetch.covidDataScotland) { results in
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
                            self.covidFetch.getCovidDataScotland()
                        }
                    }.foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                    
                }.background(Color.white)
            }
        }.navigationBarTitle("Scotland Daily Covid Statistics", displayMode: .inline)
    }
}

struct NHSDataView_Previews: PreviewProvider {
    static var previews: some View {
        ScotlandCovidStatsView()
    }
}

