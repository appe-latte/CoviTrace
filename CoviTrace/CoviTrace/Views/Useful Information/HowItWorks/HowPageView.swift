//
//  HowPageView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 19/05/2021.
//

import SwiftUI

struct HowPageView: View {
    var body: some View {
        ZStack {
            Background()
            
            TabView() {
                HowRegistrationView()
                HowPersonalInfoView()
                HowLocationView()
//                HowWorksView()
            }.tabViewStyle(PageTabViewStyle())
            
        }
    }
}
