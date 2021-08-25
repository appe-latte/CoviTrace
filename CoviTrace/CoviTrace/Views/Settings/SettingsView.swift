//
//  SettingsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/06/2021.
//

import SwiftUI
import WebKit

struct SettingsView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @Environment(\.openURL) var openURL
    let appVersion = ""
    
    init(){
        UITableView.appearance().backgroundColor = UIColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Background()
                VStack(alignment: .leading) {
                    
                    // MARK: How App Works
                    NavigationLink(destination: HowPageView()){
                        Image(systemName: "info.circle")
                            .font(.system(size: 26))
                            .foregroundColor(Color.white)
                            .padding(.trailing, 5)
                        Text("How Covitrace Works")
                            .font(.custom("Avenir", size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .padding(.leading, 15)
                    }
                    
                    // MARK: Results Submission
                    NavigationLink(
                        destination: HowToVerifyView()){
                        Image(systemName: "lifepreserver")
                            .font(.system(size: 26))
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .padding(.trailing, 5)
                        Text("How to Verify Information")
                            .font(.custom("Avenir", size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .padding(.leading, 15)
                    }
                    
                    // MARK: Security Settings
                    NavigationLink(
                        destination: SecuritySettingsView()){
                        Image(systemName: "lock")
                            .font(.system(size: 26))
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .padding(.trailing, 5)
                        Text("Security Settings")
                            .font(.custom("Avenir", size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .padding(.leading, 15)
                    }
                    
                    // MARK: Privacy Settings
                    NavigationLink(
                        destination: PrivacySettingsView()){
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 26))
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .padding(.trailing, 5)
                        Text("Privacy Settings")
                            .font(.custom("Avenir", size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .padding(.leading, 15)
                    }
                    
                    // MARK: Notifications Settings
                    NavigationLink(
                        destination: NotificationsSettingsView()){
                        Image(systemName: "app.badge")
                            .font(.system(size: 26))
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .padding(.trailing, 5)
                        Text("Notifications")
                            .font(.custom("Avenir", size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .padding(.leading, 15)
                    }
                    
                    
                    // MARK: Privacy Policy
                    NavigationLink(
                        destination: PrivacyView()){
                        Image(systemName: "folder")
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
                        destination: TermsView()){
                        Image(systemName: "folder")
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
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                }.padding(.horizontal, 5)
                
                Spacer()
                
                // MARK: Sign Out & App Version Number
                VStack(alignment: .center) {
                    Spacer()
                    // MARK: Sign Out
                    Button(action: {
                        viewModel.signOut()
                    }) {
                        HStack{
                            Text("Sign Out")
                                .font(.custom("Avenir", size: 17))
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 249 / 255, green: 73 / 255, blue: 73 / 255))
                            //                                .padding(.leading, 15)
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    //                    .padding(.leading, 75)
                    
                    
                    
                    // MARK: App Version Number
                    HStack{
                        Text("Version: \(UIApplication.appVersion!)")
                            .font(.footnote)
                    }.foregroundColor(Color(.white))
                    //                    Spacer()
                }.padding(.horizontal, 5)
            }
        }
    }
    
    
    struct SettingsView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsView()
        }
    }
    
    // MARK: Share app function
    func shareSheet() {
        guard let data = URL(string: "https://apps.apple.com/us/app/covitrace/id1553975926") else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
