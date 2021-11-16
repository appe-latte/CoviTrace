//
//  VaccinationCertView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/03/2021.
//

import SwiftUI
import Firebase
import Combine

struct VaccCertView: View {
 
    var body: some View {
        ZStack {
            Background()
            VStack(alignment: .center){
                Text("Digital Certificate shows up here...")
                    .bold()
                    .foregroundColor(.white)
            }
        }.navigationBarTitle("Digital Certificate")
    }
}
