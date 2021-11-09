//
//  AboutView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 19/05/2021.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            Background()
            TabView() {
                AboutCovitraceView()
                FaqsView()
            }.tabViewStyle(PageTabViewStyle())
            
        }
    }
}
