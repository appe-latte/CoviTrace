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
            Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
                .ignoresSafeArea()
            
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
