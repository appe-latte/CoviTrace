//
//  AreaStatsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 20/01/2021.
//

import SwiftUI
import MapKit
import CoreLocation

struct AreaStatsView: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @ObservedObject var covidFetch = CovidFetchRequest()
    @State var riskLevel = ""
    @State var currentCases: Int = 0
    @State var deaths : Int = 0
    @State var checkIn = ""
    
    
    init(){
        UITableView.appearance().backgroundColor = UIColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        ZStack
        {
            Form {
                Section {
                    Button(action: {
                        
                    }) {
                        HStack{
                            MapView(centerCoordinate: $centerCoordinate).cornerRadius(5)
                                .frame(height: 300)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    
                    // Risk Level
                    Button(action: {
                        
                    }) {
                        HStack{
                            Text("Risk Level: ")
                            Spacer()
                            Text( "MEDIUM")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    
                    // Cases
                    Button(action: {
                        
                    }) {
                        HStack{
                            Text("Cases: ")
                            Spacer()
                            Text( "\(covidFetch.totalData.confirmed)")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    
                    // Deaths
                    Button(action: {
                        
                    }) {
                        HStack{
                            Text("Deaths: ")
                            Spacer()
                            Text( "\(covidFetch.totalData.deaths)")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    
                    // Recovery
                    Button(action: {
                        
                    }) {
                        HStack{
                            Text("Recovery: ")
                            Spacer()
                            Text( "\(covidFetch.totalData.recovered)")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    
                    // Critical
                    Button(action: {
                        
                    }) {
                        HStack{
                            Text("Critical: ")
                            Spacer()
                            Text( "\(covidFetch.totalData.critical)")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                }
            }
        }.navigationBarTitle("Area Statistics")
    }
    
    struct AreaStatsView_Previews: PreviewProvider {
        static var previews: some View {
            AreaStatsView()
        }
    }
    
    struct ButtonView: View {
        @State var navigationBarBackButtonHidden = false
        var body: some View {
            Button("Show back") {
                self.navigationBarBackButtonHidden = false
            }.navigationBarBackButtonHidden(navigationBarBackButtonHidden)
        }
    }
}

