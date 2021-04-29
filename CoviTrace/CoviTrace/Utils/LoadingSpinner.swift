//
//  LoadingSpinner.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 05/03/2021.
//

import SwiftUI

struct LoadingSpinner: UIViewRepresentable {
    let isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    let color: UIColor
    
    func makeUIView(context: UIViewRepresentableContext<LoadingSpinner>) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        spinner.color = color
        return spinner
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<LoadingSpinner>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

