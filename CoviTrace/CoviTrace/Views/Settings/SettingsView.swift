//
//  SettingsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/06/2021.
//

import SwiftUI
import WebKit
import UIKit
import MessageUI

struct SettingsView: View {
    @EnvironmentObject var authModel : AuthViewModel
    
    @Environment(\.openURL) var openURL
    
    let appVersion = ""
    
    @State private var showAlert : Bool = false
    
    @State private var errTitle = ""
    @State private var errMessage = ""
    @State private var showEmailSheet = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
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
                        
                        // MARK: Verification Request

                        Button(action: {
                            self.verifRequest()
                        },
                               label: {
                            HStack {
                                Image(systemName: "checkmark.shield")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .padding(.trailing, 5)
                                Text("Request Verification")
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
                        }).sheet(isPresented: $showEmailSheet) {
                            SendMailView(result: $result, newSubject: "In-app Verification Request", newMsgBody: "I am kindly requesting verification for my recently uploaded Vaccination Card / Digital Certificate / PCR Test Results. Thank you!")
                        }
                        .alert(isPresented: $showAlert, content: {
                            Alert(title: Text("\(errTitle)"), message: Text("\(errMessage)"))
                        })
                        
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
                        
                        // MARK: Notifications
                        //                        NavigationLink(
                        //                            destination: HowToVerifyView()){
                        //                                Image(systemName: "app.badge")
                        //                                    .font(.system(size: 26))
                        //                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        //                                    .padding(.trailing, 5)
                        //                                Text("Notifications")
                        //                                    .font(.custom("Avenir", size: 17))
                        //                                    .fontWeight(.bold)
                        //                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        //                                    .padding(.leading, 15)
                        //                            }
                        
                        // MARK: Privacy Policy
                        NavigationLink(
                            destination: PrivacyPolicyView()){
                                Image(systemName: "link")
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
                                Image(systemName: "link")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .padding(.trailing, 5)
                                Text("Terms & Conditions")
                                    .font(.custom("Avenir", size: 17))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                            }
                        
                        
                        // MARK: Share The App
                        //                        Button(action: shareSheet) {
                        //                            HStack{
                        //                                Image(systemName: "square.and.arrow.up")
                        //                                    .font(.system(size: 26))
                        //                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        //                                    .padding(.trailing, 5)
                        //                                Text("Share")
                        //                                    .font(.custom("Avenir", size: 17))
                        //                                    .fontWeight(.bold)
                        //                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        //                                    .padding(.leading, 15)
                        //                            }
                        //                        }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        
                        // MARK: Sign Out
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
                    Text("Developed by Appe Latte ~")
                        .font(.footnote)
                    Text("App Version: \(UIApplication.appVersion!)")
                        .font(.footnote)
                }.foregroundColor(Color(.white))
                
                Spacer()
            }.navigationBarTitle("Settings", displayMode: .inline)
        }
    }
    
    func verifRequest() {
        if MFMailComposeViewController.canSendMail() {
            self.showEmailSheet = true
            
            self.errTitle = "Email Sent"
            self.errMessage = "Your verification request has been sent."
            self.showAlert = true
        } else {
            self.errTitle = "Alert"
            self.errMessage = "Error sending email. Please try again."
            self.showAlert = true
        }
    }
    
    // MARK: "Share" app function
    //    func shareSheet() {
    //        guard let data = URL(string: "https://apps.apple.com/us/app/covitrace/id1553975926") else { return }
    //        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
    //        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    //    }
}

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
