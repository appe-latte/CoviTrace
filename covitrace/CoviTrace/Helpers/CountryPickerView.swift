//
//  CountryPickerView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 05/01/2022.
//

import Foundation
import SwiftUI
import CountryPicker

struct CountryPickerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = CountryPickerViewController

    let countryPicker = CountryPickerViewController()

    @Binding var country: Country?

    func makeUIViewController(context: Context) -> CountryPickerViewController {
        countryPicker.selectedCountry = "ZA"
        countryPicker.delegate = context.coordinator
        return countryPicker
    }

    func updateUIViewController(_ uiViewController: CountryPickerViewController, context: Context) {
        //
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, CountryPickerDelegate {
        var parent: CountryPickerView
        init(_ parent: CountryPickerView) {
            self.parent = parent
        }
        func countryPicker(didSelect country: Country) {
            parent.country = country
            print("======= country = \(parent.country)")
        }
    }
}
