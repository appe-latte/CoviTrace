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
    
    let appVersion = ""
    var body: some View {
        ZStack
        {
            Background()
            
            VStack(alignment:.center){
                VStack {
                    // MARK: Data Usage
                    Button(action: {
                        
                    }) {
                        VStack {
                            Text("How This App Works")
                                .fontWeight(.semibold)
                                .font(.title2)
                        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 30, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(15)
                    }
                    
                    // MARK: Privacy Policy
                    Button(action: {
                        openURL(URL(string: "https://www.nhs.uk/conditions/coronavirus-covid-19/")!)
                    }) {
                        VStack {
                            Text("Privacy Policy")
                                .fontWeight(.semibold)
                                .font(.title2)
                        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 30, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(15)
                    }
                    
                    // MARK: Sign Out
                    Button(action: {
                        viewModel.signOut()
                    }) {
                        VStack {
                            Text("Sign Out")
                                .fontWeight(.semibold)
                                .font(.title2)
                        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 30, alignment: .center)
                        .padding()
                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .background(Color(red: 245 / 255, green: 246 / 255, blue: 243 / 255))
                        .cornerRadius(15)
                    }
                    
                }
                
            }.padding(5)
            .frame(minHeight: 0, maxHeight: 800 )
            Spacer()
            
            VStack{
                Spacer()
                Text("Version: \(UIApplication.appVersion!)")
                    .font(.footnote)
                    .foregroundColor(Color(red: 246/255, green: 245/255, blue: 243/255))
            }
        }.navigationBarTitle("Useful Information").navigationBarHidden(false)
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
