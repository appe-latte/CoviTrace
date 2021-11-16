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
            VStack(alignment: .center){
                Text("Digital Certificate shows up here...")
                    .bold()
                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
            }
        }.navigationBarTitle("Digital Certificate")
    }
}
