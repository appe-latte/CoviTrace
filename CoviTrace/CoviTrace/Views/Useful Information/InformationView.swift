//
//  InformationView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 12/02/2021.
//

import SwiftUI
import WebKit

struct InformationView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @Environment(\.openURL) var openURL
    @State var GlobalStatsView: Bool = false
    @State var exposureEnabled: Bool = false
    @State var locationEnabled: Bool = false
    let emergencyNumber = "999"
    let enquiryNumber = "111"
    let appVersion = ""
    
    init(){
        UITableView.appearance().backgroundColor = UIColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        ZStack {
            Form {
                // MARK: Information
                Section(header: Text("App Information")){
                    Button(action: {
                        
                    }) {
                        HStack{
                            Image(systemName: "globe")
                            Text("Global Statistics")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    // How it works
                    Button(action: {
                        
                    }) {
                        HStack{
                            Image(systemName: "hand.tap.fill")
                            Text("How CoviTrace Works")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    
                    Button(action: {
                        
                    }) {
                        HStack{
                            Image(systemName: "app.badge")
                            Text("About The App")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                }.foregroundColor(.white)
                
                // MARK: Privacy Section
                Section(header: Text("Permissions & Privacy")){
                    // Toggle Button - Exposure
                    Toggle(isOn: $exposureEnabled){
                        Image(systemName:"figure.stand.line.dotted.figure.stand")
                        Text("Exposure Logging")
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    // Toggle Button - Location
                    Toggle(isOn: $locationEnabled){
                        Image(systemName:"location.fill")
                        Text("Location Permission")
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    
                    // Privacy Policy
                    Button(action: {
                        openURL(URL(string: "https://www.nhs.uk/conditions/coronavirus-covid-19/")!)
                    }) {
                        HStack{
                            Image(systemName: "hand.raised.fill")
                            Text("Privacy Policy")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                }.foregroundColor(.white)
                
                // MARK: Important Information
                Section(header: Text("Important Information")){
                    Button(action: {
                        callNumber(phoneNumber: emergencyNumber)
                    }) {
                        HStack{
                            Image(systemName: "phone.fill.arrow.up.right")
                            Text("NHS Emergency")
                            Spacer()
                            Text("999")
                        }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                    Button(action: {
                        callNumber(phoneNumber: enquiryNumber)
                    }) {
                        HStack{
                            Image(systemName: "phone.fill.arrow.up.right")
                            Text("NHS General Enquiries")
                            Spacer()
                            Text("111")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                }.foregroundColor(.white)
                
                Section {
                    Button(action: {
                        viewModel.signOut()
                    }) {
                        HStack{
                            Image(systemName: "square.and.arrow.up")
                            Text("Sign Out")
                        }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                    
                    HStack{
                        Text("Version: \(UIApplication.appVersion!)")
                            .font(.footnote)
                            .padding(.leading, 110)
                        
                    }.foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                }
            }
        }
        .navigationBarTitle("Useful Information").navigationBarHidden(false)
    }
    
    // MARK: Function for calling feature
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                    
                }
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}


