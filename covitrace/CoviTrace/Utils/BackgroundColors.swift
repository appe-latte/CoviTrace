//
//  Background.swift
//  CoviTrace
//
//  Created by Appè Latte on 11/02/2021.
//

import SwiftUI

struct bgPurple: View {
    var body: some View {
        Rectangle()
            .fill(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
            .edgesIgnoringSafeArea(.all)
    }
}

struct bgWhite: View {
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .edgesIgnoringSafeArea(.all)
    }
}

struct bgGreen: View {
    var body: some View {
        Rectangle()
            .fill(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
            .edgesIgnoringSafeArea(.all)
    }
}
