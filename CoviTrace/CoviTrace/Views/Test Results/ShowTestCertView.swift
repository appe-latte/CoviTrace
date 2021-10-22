//
//  ShowTestCertView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 22/10/2021.
//

import SwiftUI

struct ShowTestCertView: View {
    var body: some View {
        ZStack {
            Background()
            
            VStack(alignment: .center){
                Text("Show Test Certificate Here.....")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }
}

struct ShowTestCertView_Previews: PreviewProvider {
    static var previews: some View {
        ShowTestCertView()
    }
}
