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
import SafariServices

struct ModalScannerView: View {
    @State var barcodeValue = ""
    @State var torchIsOn = false
    @State var showingAlert = false
    @State var cameraPosition = AVCaptureDevice.Position.back
    
    @State private var showSafari : Bool = false
    @Environment(\.openURL) var openURL
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        let green = Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            bgPurple()
            VStack(spacing: 5) {
                HStack {
                    Text("Scan QR code")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("dismiss")
                            .font(.custom("Avenir", size: 10))
                            .foregroundColor(purple)
                    }).frame(width: 40, height: 20)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                Spacer()
                    .frame(height: 10)
                
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
                
                Spacer()
                    .frame(height: 10)
                
                // MARK: Button to open link from QR code
                HStack {
                    Image(systemName: "link")
                        .foregroundColor(Color.white)
                        .imageScale(.small)
                    Text("Open Link")
                        .font(.custom("Avenir", size: 12))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                } .frame(width: 120, height: 40)
                    .background(green)
                    .clipShape(Capsule())
                    .padding(2)
                    .disabled((barcodeValue != "" ) ? false : true)
                    .opacity((barcodeValue != "") ? 1 : 0.4)
                    .onTapGesture {
                        showSafari.toggle()
                    }
                    .fullScreenCover(isPresented: $showSafari, content: {
                        SFSafariViewWrapper(url: URL(string: "\(barcodeValue)")!)
                    })
                
                Spacer()
                    .frame(height: 10)
                
                // MARK: Toggle Torch
                VStack(spacing: 5) {
                    HStack {
                        Button(action: {
                            self.torchIsOn.toggle()
                        }) {
                            Image(systemName: "flashlight.on.fill")
                                .imageScale(.large)
                                .foregroundColor(green)
                        }
                    }.frame(width: 60, height: 60)
                        .background(Color.white)
                        .clipShape(Circle())
                    
                    Text("Toggle Torch Light")
                        .font(.custom("Avenir", size: 12))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .padding(.top, 2)
                }
                
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

// MARK: Structure for viewing Safari link in-app
struct SFSafariViewWrapper: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url:url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
        return
    }
}
