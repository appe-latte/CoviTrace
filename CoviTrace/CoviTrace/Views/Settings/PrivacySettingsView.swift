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
    var isAppLockEnabled = false
    
    var body: some View {
        ZStack {
            bgPurple()
            
            VStack {
                Form {
                    Section {
                        HStack {
                            Image(systemName: "faceid")
                                .font(.system(size: 26))
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .padding(.trailing, 5)
                            
                            Toggle("Secure with Face ID / Touch ID", isOn: $appLockModel.isAppLockEnabled)
                                .font(.custom("Avenir", size: 14).bold())
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        }.toggleStyle(SwitchToggleStyle(tint: Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)))
                            .onChange(of: appLockModel.isAppLockEnabled, perform: { value in
                                appLockModel.appLockStateChange(appLockState: value)
                            })
                        
                        Text("When Face ID is enabled, you'll require it every time you wish to unlock the Covitrace.")
                            .font(.custom("Avenir", size: 12).bold())
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                    }
                }
            }
        }.navigationBarTitle("Privacy Settings")
            .navigationBarTitleDisplayMode(.inline)
    }
}
