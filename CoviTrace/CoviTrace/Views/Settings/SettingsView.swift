//
//  SettingsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/06/2021.
//

import UIKit
import WebKit
import Combine
import SwiftUI
import Firebase
import AlertToast
import FirebaseAuth
import SafariServices
import FirebaseFirestore

struct SettingsView: View {
    @EnvironmentObject var appLockModel : AppLockViewModel
    @EnvironmentObject var authModel : AuthViewModel
    @State var showDiasporaMedsWeb : Bool = false
    @State var showPrivacyWeb : Bool = false
    @State var showTermsWeb : Bool = false
    @State var showSaCovidStatsWeb : Bool = false
    @State var showSignOutAlert = false
    @State var isPartnersExpanded = false
    @State var rowHeight = 50.0
    
    @Environment(\.openURL) var openURL
    
    let appVersion = ""
    var isAppLockEnabled = false
    
    // MARK: Alert
    @State var showDeleteAlert = false
    @State private var showToastAlert : Bool = false
    @State private var errTitle = ""
    @State private var errMessage = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Form {
                    Section {
                        // MARK: How App Works
                        NavigationLink(destination: FaqsView()){
                            Image("info")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(1)
                            Text("About")
                                .font(.custom("Avenir", size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(.leading, 15)
                        }
                        
                        // MARK: FaceID toggle
                        VStack {
                            HStack {
                                Image("face-id")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(1)
                                Toggle("Secure App", isOn: $appLockModel.isAppLockEnabled)
                                    .font(.custom("Avenir", size: 17).bold())
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
                        }.padding(.vertical, 5)
                        
                        // MARK: Privacy Policy
                        HStack {
                            Image("pages")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(1)
                            Text("Privacy Policy")
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
                            showPrivacyWeb.toggle()
                        }
                        .fullScreenCover(isPresented: $showPrivacyWeb, content: {
                            SFSafariViewWrapper(url: URL(string: "https://www.iubenda.com/privacy-policy/52172420")!)
                        })
                        
                        // MARK: Terms & Conditions
                        HStack {
                            Image("pages")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(1)
                            Text("Terms & Conditions")
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
                            showTermsWeb.toggle()
                        }
                        .fullScreenCover(isPresented: $showTermsWeb, content: {
                            SFSafariViewWrapper(url: URL(string: "https://www.iubenda.com/terms-and-conditions/52172420")!)
                        })
                        
                        // MARK: Share The App
                        Button(action: shareSheet) {
                            HStack {
                                Image("share")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(1)
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
                    
                    Section(header: Text("Resources")) {
                        DisclosureGroup("Our Partners", isExpanded: $isPartnersExpanded) {
                            HStack {
                                Image("d-meds-logo")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding(1)
                                Text("Diaspora Meds")
                                    .font(.custom("Avenir", size: 17))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                                Spacer()
                            }.onTapGesture {
                                showDiasporaMedsWeb.toggle()
                            }
                            .fullScreenCover(isPresented: $showDiasporaMedsWeb, content: {
                                SFSafariViewWrapper(url: URL(string: "https://www.diasporameds.com")!)
                            })
                        }
                        .font(.custom("Avenir", size: 17).bold())
                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        
                        // MARK: SA Health Dept. Website
                        HStack {
                            Text("RSA Covid Statistics")
                                .font(.custom("Avenir", size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(1)
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
                    }
                    
                    // MARK: Sign Out Button
                    Section(header: Text("Account")) {
                        // MARK: Edit Profile
                        NavigationLink(destination: UserProfileEditView()){
                            Image("edit-button")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(1)
                            Text("Edit Profile")
                                .font(.custom("Avenir", size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(.leading, 15)
                        }
                        
                        // MARK: Delete Account
                        VStack {
                            HStack {
                                Button(action: {
                                    self.showDeleteAlert = true
                                }, label: {
                                    HStack {
                                        Image("trash")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .padding(1)
                                        Text("Delete My Account")
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
                                }).alert(isPresented:$showDeleteAlert) {
                                    Alert(
                                        title: Text("Are you sure you want to delete your account?"),
                                        primaryButton: .destructive(Text("Delete")) {
                                            deleteUser()
                                        },
                                        secondaryButton: .cancel()
                                    )
                                }
                            }
                            Text("This action permanently deletes your account and removes all of your information from our servers.").lineLimit(nil)
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .font(.custom("Avenir", size: 11).bold())
                        }
                        
                        Button(action: {
                            self.showSignOutAlert.toggle()
                        }, label: {
                            HStack {
                                Image("turn-off")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(1)
                                Text("Sign Out")
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
                        }).alert(isPresented: $showSignOutAlert) {
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
                    // MARK: App Version Number
                    VStack {
                        HStack(spacing: 5){
                            Spacer()
                            Text("App version: \(UIApplication.appVersion!) © All Rights Reserved 2022")
                                .font(.custom("Avenir", size: 14).bold())
                                .foregroundColor(purple)
                        }
                        HStack(spacing: 5){
                            Spacer()
                            Text("Developed by: Appè Latte")
                                .font(.custom("Avenir", size: 12).bold())
                                .foregroundColor(purple)
                        }
                    }
                }
                .environment(\.defaultMinListRowHeight, rowHeight)
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .accentColor(Color.gray.opacity(0.5))
            
        }.background(bgPurple())
    }
    
    // MARK: Delete User functiona
    func deleteUser() {
        let userId = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("users").document(userId).delete() { err in
            if let err = err  {
                print("Error: \(err)")
            } else {
                Auth.auth().currentUser!.delete { error in
                    if let error = error {
                        self.errTitle = "Error!"
                        self.errMessage = "Error deleting the user: \(error)"
                        self.showToastAlert = true
                    } else {
                        self.errTitle = "Account Deleted"
                        self.errMessage = "Your user account has successfully been deleted"
                        self.showToastAlert = true
                        authModel.signOut()
                    }
                }
            }
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
