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
            Text("\(covidFetch.totalData.critical)")
        }
    }
}

struct GlobalStatsView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalStatsView()
    }
}
