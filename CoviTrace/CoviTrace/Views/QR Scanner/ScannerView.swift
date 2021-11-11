//
//  ScannerView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/11/2021.
//

import SwiftUI
import AVFoundation
import UIKit

struct ScannerView: View {
    @ObservedObject var qrModel = QrScanViewModel()
    
    var body: some View {
        let green = Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            Background()
            VStack {
                
                VStack {
                    // MARK: Qr Scanner View
                    VStack {
                        QrCodeScannerView()
                            .found(r: self.qrModel.onFoundQrCode)
                            .torchLight(isOn: self.qrModel.torchIsOn)
                            .interval(delay: self.qrModel.scanInterval)
                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 400)
                    
                    
                    Spacer()
                    
                    Text("Scan the venue QR code to check-in.")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .lineLimit(5)
                        .padding()
                    
                    // MARK: Torch button
                    HStack {
                        Button(action: {
                            self.qrModel.torchIsOn.toggle()
                        }, label: {
                            Image(systemName: self.qrModel.torchIsOn ? "flashlight.on.fill" : "flashlight.off.fill")
                                .imageScale(.large)
                                .foregroundColor(self.qrModel.torchIsOn ? green : purple)
                                .padding()
                        })
                    }.frame(width: 50, height: 50)
                        .background(Color.white)
                        .clipShape(Circle())
                }.padding()
            }
        }.navigationBarTitle("Scan QR code")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: QR Code Delegate

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
