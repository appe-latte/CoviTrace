//
//  ScannerView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/11/2021.
//

import UIKit
import CarBode
import SwiftUI
import Firebase
import AlertToast
import CoreLocation
import AVFoundation
import FirebaseFirestore

struct ScannerView: View {
    // MARK: Objects
    @ObservedObject var qrModel = QrScanViewModel()
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
    @State var showingScanner = false
    @State var checkinHalfModal_shown = false
    
    let locationFetch = LocationFetch()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // MARK: Alert Toast property
    @State private var showToastAlert : Bool = false
    
    var body: some View {
        let green = Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            VStack(alignment: .center) {
                VStack(spacing: 5) {
                    HStack {
                        VStack(spacing: 5) {
                            VStack {
                                Button(action: {
                                    self.showingScanner.toggle()
                                }, label: {
                                    Image("scan")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .padding(1)
                                })
                                
                            }.frame(width: 50, height: 50)
                                .background(purple)
                                .clipShape(Circle())
                                .sheet(isPresented: $showingScanner) {
                                    ModalScannerView()
                                }
                            
                            Text("Scan QR code")
                                .font(.system(size: 10))
                                .foregroundColor(purple)
                        }
                        
                        Spacer()
                            .frame(width: 50)
                        
                        // MARK: Check-in button
                        VStack(spacing: 5) {
                            VStack {
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
                                            showToastAlert.toggle()
                                        })
                                    } else {
                                        print("Unknown location")
                                    }
                                }, label: {
                                    Image("location")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .padding(1)
                                })
                            }.frame(width: 50, height: 50)
                                .background(purple)
                                .clipShape(Circle())
                            
                            Text("Save Location")
                                .font(.system(size: 10))
                                .foregroundColor(purple)
                        }
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text("Scan the Covitrace Venue QR code to check-in and save your location to this device.")
                        .frame(width: UIScreen.main.bounds.size.width - 40, height: 30)
                        .font(.system(size: 12))
                        .foregroundColor(purple)
                        .lineLimit(5)
                        .padding(.vertical, 2)
                    
                    Spacer()
                }.padding()
            }.toast(isPresenting: $showToastAlert){
                AlertToast(displayMode: .alert, type: .complete(green), title: Optional("Check-in Complete"))
            }
        }.navigationBarTitle("")
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
