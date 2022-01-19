//
//  QrCodeCameraDelegate.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2022.
//

import SwiftUI
import AVFoundation

class QrCodeCameraDelegate : NSObject, AVCaptureMetadataOutputObjectsDelegate {
    var scanInterval : Double = 1.0
    var lastTime = Date(timeIntervalSince1970: 0)
    
    var onResult: (String) -> Void = {_ in }
    var mockData: String?
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            foundQrCode(stringValue)
        }
    }
    
    @objc func onSimulateScanning() {
        foundQrCode(mockData ?? "Simulated Qr code result..")
    }
    
    func foundQrCode(_ stringValue: String) {
        let now = Date()
        if now.timeIntervalSince(lastTime) >= scanInterval {
            lastTime = now
            self.onResult(stringValue)
        }
    }
}
