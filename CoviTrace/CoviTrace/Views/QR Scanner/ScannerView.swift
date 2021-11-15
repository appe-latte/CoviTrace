//
//  ScannerView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/11/2021.
//

import SwiftUI
import AVFoundation
import UIKit
import CoreLocation
import Firebase
import FirebaseFirestore

struct ScannerView: View {
    @ObservedObject var qrModel = QrScanViewModel()
    let locationFetch = LocationFetch()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
    
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
                        .frame(height: 20)
                    
                    Text("Scan the venue QR code to check-in or alternatively press the Check-in button below.")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .lineLimit(5)
                        .padding()
                    
                    Spacer()
                    
                    HStack {
                        // MARK: Check-in button
                        VStack(spacing: 5) {
                            HStack {
                                Button(action: {
                                    if let locationCheckin = self.locationFetch.lastLocation{
                                        print("Your location is: \(locationCheckin)")
                                        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
                                        let ceo: CLGeocoder = CLGeocoder()
                                        center.latitude = locationCheckin.latitude
                                        center.longitude = locationCheckin.longitude
                                        
                                        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
                                        
                                        ceo.reverseGeocodeLocation(loc, completionHandler:
                                                                    {(placemarks, error) in
                                            if (error != nil)
                                            {
                                                print("reverse geodcode fail: \(error!.localizedDescription)")
                                            }
                                            let pm = placemarks! as [CLPlacemark]
                                            if pm.count > 0 {
                                                let pm = placemarks![0]
                                                var addressString : String = ""
                                                
                                                if pm.name != nil {
                                                    addressString = addressString + pm.name! + ", "
                                                }
                                                if pm.subLocality != nil {
                                                    addressString = addressString + pm.subLocality! + ", "
                                                }
                                                if pm.thoroughfare != nil {
                                                    addressString = addressString + pm.thoroughfare! + ", "
                                                }
                                                if pm.locality != nil {
                                                    addressString = addressString + pm.locality! + ", "
                                                }
                                                if pm.country != nil {
                                                    addressString = addressString + pm.country!
                                                }
                                                
                                                let formatter = DateFormatter()
                                                formatter.locale = Locale(identifier: "nl_NL")
                                                formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
                                                
                                                let now = Date()
                                                let datetime = formatter.string(from: now)
                                                
                                                let db = Firestore.firestore();                                db.collection("checkins").document().setData(["userId": authModel.userSession!.uid, "latitude": locationCheckin.latitude, "longitude": locationCheckin.longitude, "date": datetime, "address": addressString])
                                            }
                                        })
                                    } else {
                                        print("Unknown location")
                                    }
                                }, label: {
                                    Image(systemName: "mappin")
                                        .imageScale(.large)
                                        .foregroundColor(Color.white)
                                        .padding()
                                })
                            }.frame(width: 50, height: 50)
                                .background(green)
                                .clipShape(Circle())
                            
                            Text("Check-in")
                                .font(.system(size: 10))
                                .foregroundColor(Color.white)
                        }
                        
                        Spacer()
                        
                        // MARK: Torch button
                        VStack(spacing: 5) {
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
                            
                            Text("Torch On / Off")
                                .font(.system(size: 10))
                                .foregroundColor(Color.white)
                        }
                    }
                }.padding()
            }
        }.navigationBarTitle("Scan QR code")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: QR Code Camera Delegate
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
