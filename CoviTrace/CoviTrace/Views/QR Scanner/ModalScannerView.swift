//
//  QrCodeScannerView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 23/10/2021.
//
// Embedded CardBode package for QR codes

import UIKit
import SwiftUI
import CarBode
import AVFoundation

struct ModalScannerView: View {
    @State var barcodeValue = ""
    @State var torchIsOn = false
    @State var showingAlert = false
    @State var cameraPosition = AVCaptureDevice.Position.back
    
    var body: some View {
        let green = Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            Background()
            VStack(spacing: 5) {
                Spacer()
                    .frame(height: 10)
                
                // MARK: Sheet Header
                VStack {
                    Text("Scan QR code")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }.padding(.horizontal, 10)
                
                // MARK: Camera
                VStack(spacing: 5) {
                    HStack {
                        Button(action: {
                            if cameraPosition == .back {
                                cameraPosition = .front
                            }else{
                                cameraPosition = .back
                            }
                        }) {
                            if cameraPosition == .back {
                                VStack(spacing: 2) {
                                    Image(systemName: "camera")
                                        .font(.system(size: 24))
                                        .foregroundColor(purple)
                                    Text("Back")
                                        .font(.custom("Avenir", size: 14))
                                        .foregroundColor(purple)
                                }
                            } else {
                                VStack(spacing: 2) {
                                    Image(systemName: "camera")
                                        .font(.system(size: 24))
                                        .foregroundColor(purple)
                                    Text("Front")
                                        .font(.custom("Avenir", size: 14))
                                        .foregroundColor(purple)
                                }
                            }
                        }
                    }.frame(width: 80, height: 80)
                        .background(Color.white)
                        .clipShape(Circle())
                    
                    if cameraPosition == .back {
                        Text("Using Back Camera")
                            .font(.custom("Avenir", size: 12))
                            .foregroundColor(Color.white)
                    } else {
                        Text("Using Front Camera")
                            .font(.custom("Avenir", size: 12))
                            .foregroundColor(Color.white)
                    }
                    
                }
                
                // MARK: Scanner View
                VStack(spacing: 2) {
                    
                    CBScanner(
                        supportBarcode: .constant([.qr, .code128]),
                        torchLightIsOn: $torchIsOn,
                        cameraPosition: $cameraPosition
                    ){
                        print("BarCodeType =",$0.type.rawValue, "Value =",$0.value)
                        barcodeValue = $0.value
                    }
                onDraw: {
                    
                    let lineColor = UIColor(green)
                    let fillColor = UIColor(purple.opacity(0.25))
                    
                    // MARK: Draw border around QR code edges
                    $0.draw(lineWidth: 1.5, lineColor: lineColor, fillColor: fillColor)
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 400, alignment: .topLeading)
                        .overlay(cameraFrame()
                                    .stroke(lineWidth: 5)
                                    .frame(width: 500, height: 250)
                                    .foregroundColor(green))
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text("QR code found!"), message: Text("\(barcodeValue)"), dismissButton: .default(Text("Close")))
                }
                
                Text(barcodeValue)
                    .font(.custom("Avenir", size: 16))
                    .foregroundColor(Color.white)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                
                Spacer()
            }
            
        }
    }
}

struct cameraFrame: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height
            
            path.addLines( [
                
                CGPoint(x: 0, y: height * 0.25),
                CGPoint(x: 0, y: 0),
                CGPoint(x:width * 0.25, y:0)
            ])
            
            path.addLines( [
                
                CGPoint(x: width * 0.75, y: 0),
                CGPoint(x: width, y: 0),
                CGPoint(x:width, y:height * 0.25)
            ])
            
            path.addLines( [
                
                CGPoint(x: width, y: height * 0.75),
                CGPoint(x: width, y: height),
                CGPoint(x:width * 0.75, y: height)
            ])
            
            path.addLines( [
                
                CGPoint(x:width * 0.25, y: height),
                CGPoint(x:0, y: height),
                CGPoint(x:0, y:height * 0.75)
                
            ])
            
        }
    }
}

