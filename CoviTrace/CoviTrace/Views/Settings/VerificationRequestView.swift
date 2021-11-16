//
//  VerificationRequestView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 15/11/2021.
//

import SwiftUI

struct VerificationRequestView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Email form goes here...")
                    .font(.system(size: 14))
                    .foregroundColor(Color.green)
            }
        }.background(Color.white)
            .ignoresSafeArea()
            .navigationTitle("Request Verification Form")
    }
}
