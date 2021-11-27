//
//  PrivacySettingsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/11/2021.
//

import SwiftUI
import Combine

struct PrivacySettingsView: View {
    @EnvironmentObject private var appLockModel : AppLockViewModel
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                Form {
                    // MARK: Face ID toggle ON / OFF
                    Section {
                        HStack {
                            Image(systemName: "faceid")
                                .font(.system(size: 26))
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .padding(.trailing, 5)
                            Toggle("Secure with Face ID", isOn: $appLockModel.isAppLockEnabled)
                                .font(.custom("Avenir", size: 17).bold())
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        }.toggleStyle(SwitchToggleStyle(tint: Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)))
                            .onChange(of: appLockModel.isAppLockEnabled, perform: { value in
                                appLockModel.appLockStateChange(appLockState: value)
                            })
                        
                        Text("When Face ID is enabled, you'll require it every time you wish to unlock the Covitrace.")
                            .font(.custom("Avenir", size: 12).bold())
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        
                        // MARK: Unlock period
                        Group {
                            // MARK: Immediately
                            HStack {
                                Button(action: {
                                    
                                },
                                       label: {
                                    Text("Immediately")
                                        .font(.custom("Avenir", size: 17).bold())
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                })
                            }
                            
                            // MARK: 15 minutes
                            HStack {
                                Button(action: {
                                    
                                },
                                       label: {
                                    Text("After 15 minutes")
                                        .font(.custom("Avenir", size: 17).bold())
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                })
                            }
                            
                            // MARK: 30 minutes
                            HStack {
                                Button(action: {
                                    
                                },
                                       label: {
                                    Text("After 30 minutes")
                                        .font(.custom("Avenir", size: 17).bold())
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                })
                            }
                            
                            
                            // MARK: 60 minutes
                            HStack {
                                Button(action: {
                                    
                                },
                                       label: {
                                    Text("After 60 minutes")
                                        .font(.custom("Avenir", size: 17).bold())
                                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                })
                            }
                            
                        }
                    }
                    
                    // MARK: Pin Code toggle ON / OFF
                    Section {
                        HStack {
                            Image(systemName: "lock.open")
                                .font(.system(size: 26))
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .padding(.trailing, 5)
                            Toggle("Secure with pin", isOn: $appLockModel.isAppLockEnabled)
                                .font(.custom("Avenir", size: 17).bold())
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        }.toggleStyle(SwitchToggleStyle(tint: Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)))
                            .onChange(of: appLockModel.isAppLockEnabled, perform: { value in
                                appLockModel.appLockStateChange(appLockState: value)
                            })
                    }
                }
            }
        }.navigationBarTitle("Privacy Settings")
            .navigationBarTitleDisplayMode(.inline)
    }
}
