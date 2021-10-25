//
//  QrCodeScannerView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 23/10/2021.
//

import SwiftUI

struct QrCodeScannerView: View {
    var body: some View {
        ZStack {
            Background()
            VStack {
                Text("QR Scanner opens here...")
                    .font(.body)
                    .foregroundColor(.white)
                    .bold()
            }
        }.navigationBarTitle("Scan QR code")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct QrCodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        QrCodeScannerView()
    }
}
