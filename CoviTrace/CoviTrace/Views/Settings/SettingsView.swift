//
//  SettingsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/06/2021.
//

import UIKit
import SwiftUI
import WebKit
import SafariServices

struct SettingsView: View {
    @EnvironmentObject var authModel : AuthViewModel
    @State private var showSafari : Bool = false
    @Environment(\.openURL) var openURL
    
    let appVersion = ""
    
    var body: some View {
        ZStack {
            Background()
            VStack(alignment: .center) {
                Form {
                    Section {
                        // MARK: How App Works
                        NavigationLink(destination: AboutView()){
                            Image(systemName: "info.circle")
                                .font(.system(size: 26))
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .padding(.trailing, 5)
                            Text("About Covitrace")
                                .font(.custom("Avenir", size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(.leading, 15)
                        }
                        
                        // MARK: FAQs Section
                        NavigationLink(destination: FaqsView()){
                            Image(systemName: "questionmark.circle")
                                .font(.system(size: 26))
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .padding(.trailing, 5)
                            Text("FAQs")
                                .font(.custom("Avenir", size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(.leading, 15)
                        }
                        
                        // MARK: Privacy Settings
                        NavigationLink(
                            destination: PrivacySettingsView()){
                                Image(systemName: "lock")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .padding(.trailing, 5)
                                Text("Privacy Settings")
                                    .font(.custom("Avenir", size: 17))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                            }
                        
                        // MARK: Privacy Policy
                        NavigationLink(
                            destination: PrivacyPolicyView()){
                                Image(systemName: "link.circle")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .padding(.trailing, 5)
                                Text("Privacy Policy")
                                    .font(.custom("Avenir", size: 17))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                            }
                        
                        // MARK: Terms and Conditions
                        NavigationLink(
                            destination: TermsCondView()){
                                Image(systemName: "link.circle")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .padding(.trailing, 5)
                                Text("Terms & Conditions")
                                    .font(.custom("Avenir", size: 17))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                            }
                        
                        // MARK: Developer's Website
                        HStack {
                            Image(systemName: "globe")
                                .font(.system(size: 26))
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .padding(.trailing, 5)
                            Text("Developer's Site")
                                .font(.custom("Avenir", size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(.leading, 15)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .font(Font.title.weight(.semibold))
                                .foregroundColor(Color(.gray)).opacity(0.5)
                                .frame(width: 13, height: 13)
                        }.onTapGesture {
                            showSafari.toggle()
                        }
                        .fullScreenCover(isPresented: $showSafari, content: {
                            SFSafariViewWrapper(url: URL(string: "https://www.appe-latte.co.uk")!)
                        })
                        
                        // MARK: Share The App
                        Button(action: shareSheet) {
                            HStack{
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .padding(.trailing, 5)
                                Text("Share")
                                    .font(.custom("Avenir", size: 17))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .scaledToFit()
                                    .font(Font.title.weight(.semibold))
                                    .foregroundColor(Color(.gray)).opacity(0.5)
                                    .frame(width: 13, height: 13)
                            }
                        }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        
                        // MARK: Sign Out Button
                        Button(action: {
                            authModel.signOut()
                        }) {
                            HStack{
                                Text("Sign Out")
                                    .font(.custom("Avenir", size: 17))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 249 / 255, green: 73 / 255, blue: 73 / 255))
                                    .padding(.leading, 15)
                            }
                        }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .padding(.leading, 105)
                        
                    }.foregroundColor(.white)
                }.background(Color.black)
                
                // MARK: App Version Number
                HStack(spacing: 5){
                    Text("Developed by Appe Latte Ltd. (UK) ~")
                        .font(.custom("Avenir", size: 12))
                    Text("App Version: \(UIApplication.appVersion!)")
                        .font(.custom("Avenir", size: 12))
                }.foregroundColor(Color(.white))
                
                Spacer()
            }.navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
