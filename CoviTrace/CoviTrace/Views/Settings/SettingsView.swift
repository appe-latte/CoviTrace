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
    @EnvironmentObject private var appLockModel : AppLockViewModel
    @EnvironmentObject var authModel : AuthViewModel
    @State private var showPrivacyWeb : Bool = false
    @State private var showSaCovidStatsWeb : Bool = false
    @State var showSignOutAlert = false
    
    @Environment(\.openURL) var openURL
    
    let appVersion = ""
    var isAppLockEnabled = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Form {
                    Section {
                        
                        // MARK: How App Works
                        NavigationLink(destination: AboutView()){
                            Image("info")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(1)
                            Text("About Covitrace")
                                .font(.custom("Avenir", size: 15))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(.leading, 15)
                        }
                        
                        // MARK: FAQs Section
                        NavigationLink(destination: FaqsView()){
                            Image("question")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(1)
                            Text("FAQs")
                                .font(.custom("Avenir", size: 15))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(.leading, 15)
                        }
                        
                        // MARK: Privacy Settings
                        NavigationLink(
                            destination: AccountSettingsView()){
                                Image("edit")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(1)
                                Text("Account Settings")
                                    .font(.custom("Avenir", size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                            }
                        
                        VStack {
                            HStack {
                                Image("face-id")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(1)
                                Toggle("Secure App", isOn: $appLockModel.isAppLockEnabled)
                                    .font(.custom("Avenir", size: 15).bold())
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                            }.toggleStyle(SwitchToggleStyle(tint: Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)))
                                .onChange(of: appLockModel.isAppLockEnabled, perform: { value in
                                    appLockModel.appLockStateChange(appLockState: value)
                                })
                            
                            HStack {
                                Text("Use Face ID / Touch ID to unlock when re-opening the app.")
                                    .font(.custom("Avenir", size: 11).bold())
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .padding(1)
                                
                                Spacer()
                            }
                        }
                        
                        // MARK: Privacy Policy
                        HStack {
                            Image("pages")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(1)
                            Text("Privacy Policy")
                                .font(.custom("Avenir", size: 15))
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
                            showPrivacyWeb.toggle()
                        }
                        .fullScreenCover(isPresented: $showPrivacyWeb, content: {
                            SFSafariViewWrapper(url: URL(string: "https://www.iubenda.com/privacy-policy/52172420")!)
                        })
                        
                        // MARK: Share The App
                        Button(action: shareSheet) {
                            HStack {
                                Image("share")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(1)
                                Text("Share")
                                    .font(.custom("Avenir", size: 15))
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
                    
                    Section(header: Text("Covid Statistics")) {
                        // MARK: SA Health Dept. Website
                        HStack {
                            Image("discovery")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(1)
                            Text("RSA Covid Statistics")
                                .font(.custom("Avenir", size: 15))
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
                            showSaCovidStatsWeb.toggle()
                        }
                        .fullScreenCover(isPresented: $showSaCovidStatsWeb, content: {
                            SFSafariViewWrapper(url: URL(string: "https://www.sacoronavirus.co.za")!)
                        })
                    }.foregroundColor(.gray)
                    
                    //                    Section(header: Text("In partnership with:")) {
                    //                        HStack(spacing: 10) {
                    //                            // Partner
                    //                            Image("logo")
                    //                                .resizable()
                    //                                .frame(width: 80, height: 80)
                    //                                .clipShape(Circle())
                    //                                .padding(1)
                    //
                    //                            // Partner
                    //                            Image("logo")
                    //                                .resizable()
                    //                                .frame(width: 80, height: 80)
                    //                                .clipShape(Circle())
                    //                                .padding(1)
                    //
                    //                            // Partner
                    //                            Image("logo")
                    //                                .resizable()
                    //                                .frame(width: 80, height: 80)
                    //                                .clipShape(Circle())
                    //                                .padding(1)
                    //
                    //                            // Partner
                    //                            Image("logo")
                    //                                .resizable()
                    //                                .frame(width: 80, height: 80)
                    //                                .clipShape(Circle())
                    //                                .padding(1)
                    //                        }
                    //                    }
                    
                    // MARK: Sign Out Button
                    Section {
                        Text("For all account related enquiries email the administrator at: admin@covitrace.co.za").lineLimit(nil)
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .font(.custom("Avenir", size: 11).bold())
                            .accentColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        
                        Button(action: {
                            self.showSignOutAlert.toggle()
                        }, label: {
                            HStack {
                                Image("turn-off")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding(2)
                                Text("Sign Out")
                                    .font(.custom("Avenir", size: 15))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 249 / 255, green: 73 / 255, blue: 73 / 255))
                            }
                        }).padding(.leading, 105)
                            .alert(isPresented: $showSignOutAlert) {
                                Alert(
                                    title: Text("Sign Out"),
                                    message: Text("Continue to log out of the Covitrace app."),
                                    primaryButton: .destructive(Text("Sign Out")) {
                                        authModel.signOut()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                    }
                }
                
                // MARK: App Version Number
                HStack(spacing: 5){
                    Text("v:\(UIApplication.appVersion!) ~")
                        .font(.custom("Avenir", size: 12))
                    Text("Covitrace © All Rights Reserved (2022)")
                        .font(.custom("Avenir", size: 12))
                }.foregroundColor(Color(.white))
                
                Spacer()
            }.navigationBarTitle("Settings", displayMode: .inline)
        }.background(bgPurple())
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
