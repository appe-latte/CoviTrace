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
                    //                    Button(action: {
                    //
                    //                    }) {
                    //                        HStack{
                    //                            Image(systemName: "app.badge")
                    //                            Text("About This App")
                    //                            Spacer()
                    //                            Image(systemName: "chevron.right")
                    //                        }
                    //                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    NavigationLink(
                        destination: AboutAppView()){
                        Image(systemName: "app.badge")
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        Text("About This App")
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                    
                    // MARK: How It Works
                    NavigationLink(
                        destination: HowAppWorksView()){
                        Image(systemName: "hand.tap.fill")
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        Text("How CoviTrace Works")
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                    
                    // MARK: Share The App
                    Button(action: shareSheet) {
                        HStack{
                            Image(systemName: "square.and.arrow.up")
                            Text("Share This App")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                }.foregroundColor(.white)
                
                // MARK: Privacy Section
                Section(header: Text("Permissions & Privacy")){
                    // MARK: Toggle Button - Exposure
//                    Toggle(isOn: $exposureEnabled){
//                        Image(systemName:"figure.stand.line.dotted.figure.stand")
//                        Text("Exposure Logging")
//                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
//                    .toggleStyle(SwitchToggleStyle(tint: Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)))
                    
                    // MARK: Privacy Policy
                    NavigationLink(
                        destination: PrivacyPolicyView()){
                        Image(systemName: "hand.raised.fill")
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        Text("Privacy Policy")
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                    
                }.foregroundColor(.white)
                
                // MARK: Important Information
                Section(header: Text("Important Information")){
                    // MARK: 999
                    Button(action: {
                        callNumber(phoneNumber: emergencyNumber)
                    }) {
                        HStack{
                            Image(systemName: "phone.fill.arrow.up.right")
                            Text("NHS Emergency")
                            Spacer()
                            Text("999")
                                .fontWeight(.semibold)
                        }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    }
                    // MARK: 111
                    Button(action: {
                        callNumber(phoneNumber: enquiryNumber)
                    }) {
                        HStack{
                            Image(systemName: "phone.fill.arrow.up.right")
                            Text("NHS General Enquiries")
                            Spacer()
                            Text("111")
                                .fontWeight(.semibold)
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    
                    // MARK: NHS Weblink
                    Button(action: {
                        openURL(URL(string: "https://www.nhs.uk/conditions/coronavirus-covid-19/")!) 
                    }) {
                        HStack{
                            Image(systemName: "link")
                            Text("NHS.UK")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }.foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    
                    // MARK: WHO Weblink
                    Button(action: {
                        openURL(URL(string: "https://www.who.int/emergencies/diseases/novel-coronavirus-2019")!)
                    }) {
                        HStack{
                            Image(systemName: "link")
                            Text("WHO.INT")
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
                            Text("Sign Out")
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
        guard let data = URL(string: "http://www.getcovitrace.com") else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
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
