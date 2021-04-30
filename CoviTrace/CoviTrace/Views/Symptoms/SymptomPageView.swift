//
//  SymptomPageView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 25/01/2021.
//

import SwiftUI

struct SymptomPageView: View {
    
    var body: some View {
        ZStack {
            // MARK: BACKGROUND COLOUR CODE:
            Background()
            
            TabView() {
                SymptomCheckIntroView()
                SymptomFeverView()
                SymptomCoughView()
                SymptomSmellView()
            }.tabViewStyle(PageTabViewStyle())
        }
    }
}


