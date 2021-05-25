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
                    // MARK: How It Works
                    NavigationLink(
                        destination: HowPageView()){
                        Image(systemName: "hand.tap.fill")
                            .font(.title)
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .padding(.trailing, 5)
                        Text("How CoviTrace Works")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .padding(.leading, 15)
                    }
                    
                    // MARK: Results Submission
                    NavigationLink(
                        destination: UploadResultsView()){
                        Image(systemName: "plus.app.fill")
                            .font(.title)
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .padding(.trailing, 5)
                        Text("How to Verify Information")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .padding(.leading, 15)
                    }
                    
                    // MARK: Share The App
                    Button(action: shareSheet) {
                        HStack{
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .padding(.trailing, 5)
                            Text("Share This App")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(.leading, 15)
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                }.foregroundColor(.white)
                
                // MARK: Privacy Section
                Section(header: Text("Permissions & Privacy")){
                    // MARK: Privacy Policy
                    Button(action: {
                        openURL(URL(string: "https://www.iubenda.com/privacy-policy/52172420")!)
                    }) {
                        HStack{
                            Image("help")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(5)
                                .scaledToFit()
                                .padding(.trailing, 5)
                            Text("Privacy Policy")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(.leading, 15)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    
                    // MARK: Terms and Conditions
                    Button(action: {
                        openURL(URL(string: "https://www.iubenda.com/terms-and-conditions/52172420")!)
                    }) {
                        HStack{
                            Image("help")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(5)
                                .scaledToFit()
                            Text("Terms & Condition's")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                .padding(.leading, 15)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    
                }.foregroundColor(.white)
                
                // MARK: Sign Out
                Section {
                    Button(action: {
                        viewModel.signOut()
                    }) {
                        HStack{
                            Image(systemName: "tray.and.arrow.up")
                                .font(.title3)
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                .padding(.trailing, 5)
                            Text("Sign Out")
                                .font(.body)
                                .fontWeight(.semibold)
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .padding(.leading, 105)
                    
                    HStack{
                        Text("Version: \(UIApplication.appVersion!)")
                            .font(.footnote)
                            .padding(.leading, 115)
                    }.foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                }
            }
        }
        .navigationBarTitle("").navigationBarHidden(false)
    }
    
    // MARK: Function for calling feature
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // MARK: Fallback on earlier versions
                    application.openURL(phoneCallURL as URL)
                }
            }
        }
    }
    
    // MARK: Share app function
    func shareSheet() {
        guard let data = URL(string: "https://www.covitrace.co.uk") else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
