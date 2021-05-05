//
//  UKCovidStatsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 04/05/2021.
//

import SwiftUI

struct UKCovidStatsView: View {
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor.init(red: 83 / 255, green: 82 / 255, blue: 116 / 255, alpha: 1.0)
        
    }
    
    var body: some View {
        ScrollView(.vertical) {
            ZStack {
                Background().edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading){
                    
                    // MARK: Covid Stats England
                    Section(header: Text("England").fontWeight(.bold)){
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Date:")
                                    .font(.body)
                                
                                Text("2021-05-03")
                                    .font(.body)
                                    .bold()
                            }
                            
                            // MARK: Latest Figures
                            HStack {
                                // MARK: Latest Cases
                                VStack {
                                    Text("New Cases")
                                        .font(.body)
                                        .foregroundColor(.white)
                                    Text("1234")
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .bold()
                                }.frame(width: 125, height: 125)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(2)
                                .cornerRadius(15)
                                
                                // MARK: Latest Deaths
                                VStack {
                                    Text("New Deaths")
                                        .font(.body)
                                        .foregroundColor(.white)
                                    Text("1234")
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .bold()
                                }.frame(width: 125, height: 125)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(2)
                                .cornerRadius(15)
                            }
                            
                            // MARK: Cumulative Figures
                            HStack {
                                // MARK: Cumulative Cases
                                VStack {
                                    Text("Total Cases")
                                        .font(.body)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("1234")
                                        .font(.body)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .bold()
                                }.frame(width: 125, height: 125)
                                .background(Color(.white))
                                .padding(2)
                                .cornerRadius(15)
                                
                                // MARK: Cumulative Deaths
                                VStack {
                                    Text("Total Deaths")
                                        .font(.body)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("1234")
                                        .font(.body)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .bold()
                                }.frame(width: 125, height: 125)
                                .background(Color(.white))
                                .padding(2)
                                .cornerRadius(15)
                            }
                        }
                    }
                    
                    // MARK: Covid Stats Scotland
                    Section(header: Text("Scotland").fontWeight(.bold)){
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Date:")
                                    .font(.body)
                                
                                Text("2021-05-03")
                                    .font(.body)
                                    .bold()
                            }
                            
                            // MARK: Latest Figures
                            HStack {
                                // MARK: Latest Cases
                                VStack {
                                    Text("New Cases")
                                        .font(.body)
                                        .foregroundColor(.white)
                                    Text("1234")
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .bold()
                                }.frame(width: 125, height: 125)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(2)
                                .cornerRadius(15)
                                
                                // MARK: Latest Deaths
                                VStack {
                                    Text("New Deaths")
                                        .font(.body)
                                        .foregroundColor(.white)
                                    Text("1234")
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .bold()
                                }.frame(width: 125, height: 125)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(2)
                                .cornerRadius(15)
                            }
                            
                            // MARK: Cumulative Figures
                            HStack {
                                // MARK: Cumulative Cases
                                VStack {
                                    Text("Total Cases")
                                        .font(.body)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("1234")
                                        .font(.body)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .bold()
                                }.frame(width: 125, height: 125)
                                .background(Color(.white))
                                .padding(2)
                                .cornerRadius(15)
                                
                                // MARK: Cumulative Deaths
                                VStack {
                                    Text("Total Deaths")
                                        .font(.body)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("1234")
                                        .font(.body)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .bold()
                                }.frame(width: 125, height: 125)
                                .background(Color(.white))
                                .padding(2)
                                .cornerRadius(15)
                            }
                        }
                    }
                    
                    // MARK: Covid Stats Wales
                    Section(header: Text("Wales").fontWeight(.bold)){
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Date:")
                                    .font(.body)
                                
                                Text("2021-05-03")
                                    .font(.body)
                                    .bold()
                            }
                            
                            // MARK: Latest Figures
                            HStack {
                                // MARK: Latest Cases
                                VStack {
                                    Text("New Cases")
                                        .font(.body)
                                        .foregroundColor(.white)
                                    Text("1234")
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .bold()
                                }.frame(width: 125, height: 125)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(2)
                                .cornerRadius(15)
                                
                                // MARK: Latest Deaths
                                VStack {
                                    Text("New Deaths")
                                        .font(.body)
                                        .foregroundColor(.white)
                                    Text("1234")
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .bold()
                                }.frame(width: 125, height: 125)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(2)
                                .cornerRadius(15)
                            }
                            
                            // MARK: Cumulative Figures
                            HStack {
                                // MARK: Cumulative Cases
                                VStack {
                                    Text("Total Cases")
                                        .font(.body)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("1234")
                                        .font(.body)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .bold()
                                }.frame(width: 125, height: 125)
                                .background(Color(.white))
                                .padding(2)
                                .cornerRadius(15)
                                
                                // MARK: Cumulative Deaths
                                VStack {
                                    Text("Total Deaths")
                                        .font(.body)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    Text("1234")
                                        .font(.body)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .bold()
                                }.frame(width: 125, height: 125)
                                .background(Color(.white))
                                .padding(2)
                                .cornerRadius(15)
                            }
                        }
                    }
                }.foregroundColor(.white)
                
            }
            .padding(.top, 100)
        }.navigationBarTitle("UK Covid Statistics", displayMode: .inline)
        .background(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        .ignoresSafeArea()
    }
}

struct UKCovidStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UKCovidStatsView()
    }
}
