//
//  OnboardingView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 06/03/2021.
//

import SwiftUI

struct OnboardingView: View {
    
    var subviews = [
        UIHostingController(rootView: Subview(imageString: "ill")),
        UIHostingController(rootView: Subview(imageString: "hand-wash")),
        UIHostingController(rootView: Subview(imageString: "shield"))
    ]
    
    var body: some View {
        Text("Hello World")
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
