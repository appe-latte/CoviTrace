//
//  HealthTipsPageView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/02/2021.
//

import SwiftUI

struct HealthTipsPageView: View {
    
    var body: some View {
        ZStack {
            // MARK: BACKGROUND COLOUR CODE:
            Background()
            
            TabView() {
                HealthTipsWashView()
                HealthTipsDistanceView()
                HealthTipsCoverView()
                HealthTipsSanitiseView()
                HealthTipsFoodView()
                HealthTipsRestView()
            }.tabViewStyle(PageTabViewStyle())
            
        }
    }
}
