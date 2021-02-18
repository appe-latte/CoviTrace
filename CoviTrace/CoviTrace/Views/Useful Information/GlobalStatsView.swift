//
//  GlobalStatsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 13/02/2021.
//

import SwiftUI

struct GlobalStatsView: View {
    @ObservedObject var covidFetch = CovidFetchRequest()
    
    var body: some View {
        ZStack(){
            Background()
            HStack {
                Text("Total Deaths: \(covidFetch.totalData.deaths)")
                    .fontWeight(.semibold)
                    .font(.title3)
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 40, alignment: .center)
            .padding(5)
            .foregroundColor(.white)
            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
            .cornerRadius(30)
        }
    }
}

struct GlobalStatsView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalStatsView()
    }
}
