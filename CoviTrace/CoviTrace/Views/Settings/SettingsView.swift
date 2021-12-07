//
//  SettingsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/06/2021.
//

import UIKit
import WebKit
import SwiftUI
import SafariServices

struct SettingsView: View {
    @EnvironmentObject var authModel : AuthViewModel
    @State private var showSafari : Bool = false
    @Environment(\.openURL) var openURL
    
    let appVersion = ""
    
    var body: some View {
        ZStack {
            bgPurple()
            
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
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .padding(.trailing, 5)
                                Text("Account Settings")
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
                    }.foregroundColor(.white)
                    
                    Section(header: Text("health.gov.za")) {
                        // MARK: SA Health Dept. Website
                        HStack {
                            Image(systemName: "globe")
                                .font(.system(size: 26))
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .padding(.trailing, 5)
                            Text("RSA Covid Statistics")
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
                            SFSafariViewWrapper(url: URL(string: "https://www.sacoronavirus.co.za")!)
                        })
                        
                        // MARK: EVDS Registration
                        HStack {
                            Image(systemName: "globe")
                                .font(.system(size: 26))
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .padding(.trailing, 5)
                            Text("EVDS Registration")
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
                            SFSafariViewWrapper(url: URL(string: "https://vaccine.enroll.health.gov.za")!)
                        })
                        
                        // MARK: Vaccination Bookings
                        HStack {
                            Image(systemName: "globe")
                                .font(.system(size: 26))
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .padding(.trailing, 5)
                            Text("Book Vaccination")
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
                            SFSafariViewWrapper(url: URL(string: "https://vaccine.booking.health.gov.za")!)
                        })
                    }.foregroundColor(.gray)
                    
                    // MARK: Sign Out Button
                    Section {
                        
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
                    }
                    
                }.background(Color.black)
                
                // MARK: App Version Number
                HStack(spacing: 5){
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

// MARK: "Share" app function
func shareSheet() {
    guard let data = URL(string: "https://apps.apple.com/us/app/covitrace/id1553975926") else { return }
    let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
}
