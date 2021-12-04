//
//  QrScanViewModel.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/11/2021.
//

import Foundation

class QrScanViewModel: ObservableObject {
    let scanInterval : Double = 1.0 // how often the camera checks for a new QR code.
    
    @Published var lastQrCode: String = ""
    @Published var torchIsOn: Bool = false
    
    func onFoundQrCode(_ code: String) {
        self.lastQrCode = code
    }
}
