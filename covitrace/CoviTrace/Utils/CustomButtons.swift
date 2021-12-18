//
//  CustomButtons.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 16/12/2021.
//

import SwiftUI

let green = Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)
let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)

struct purpleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 150, height: 50)
            .background(bgPurple())
            .cornerRadius(10)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct whiteButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 150, height: 50)
            .background(bgWhite())
            .cornerRadius(10)
            .foregroundColor(green)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct purpleBorderButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 150, height: 50)
            .background(bgWhite())
            .cornerRadius(10)
            .foregroundColor(purple)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(purple, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct purpleRoundButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 80)
            .background(bgPurple())
            .clipShape(Circle())
            .foregroundColor(Color.white)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct greenButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 150, height: 50)
            .background(bgGreen())
            .cornerRadius(10)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}