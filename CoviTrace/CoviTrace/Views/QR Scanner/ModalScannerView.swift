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
import CryptoSwift
import AlertToast

struct ModalScannerView: View {
    @State var barcodeValue = ""
    @State var torchIsOn = false
    @State var showingAlert = false
    @State var cameraPosition = AVCaptureDevice.Position.back
    
    @State private var showSafari : Bool = false
    @Environment(\.openURL) var openURL
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Alert
    @State private var showToastAlert : Bool = false
    @State private var errTitle = ""
    @State private var errMessage = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 5) {
                HStack {
                    Text("Scan QR code")
                        .foregroundColor(purple)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("close-p")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }).padding(5)
                        .clipShape(Circle())
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
                        do {
                            let encryptedValue = $0.value
                            barcodeValue = encryptedValue.aesDecrypt(key: "HR-HFg_AQab*jAW4VE8W@3xQ6*CTv.LwPGu*BmoDmy*wgWeeuhPvusP9e.2@KpMk") ?? ""
                            print(barcodeValue)
                            showingAlert = true
                        } catch {
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                }.toast(isPresenting: $showingAlert){
                    AlertToast(type: .regular, title: "Vaccination Status", subTitle: "\(barcodeValue)")
                }
                
                Spacer()
                    .frame(height: 10)
                
                Spacer()
                    .frame(height: 10)
                
                // MARK: Toggle Torch
                VStack {
                    HStack {
                        Spacer()
                        VStack(spacing: 5) {
                            Button(action: {
                                self.torchIsOn.toggle()
                            }, label: {
                                Image(systemName: "flashlight.on.fill")
                                    .imageScale(.large)
                                    .foregroundColor(Color.white)
                            }).frame(width: 60, height: 60)
                                .background(green)
                                .clipShape(Circle())
                            
                            Text("Toggle Torch Light")
                                .font(.custom("Avenir", size: 12))
                                .fontWeight(.semibold)
                                .foregroundColor(green)
                                .padding(.top, 2)
                        }
                    }
                }.padding(15)
                
                Spacer()
            }
        }
        .background(bgWhite())
        .accentColor(purple)
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
