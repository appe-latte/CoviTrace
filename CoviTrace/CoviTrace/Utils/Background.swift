//
//  Background.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/02/2021.
//

import SwiftUI

struct Background: View {
    var body: some View {
        Rectangle()
            .fill(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
            .edgesIgnoringSafeArea(.all)
    }
}
