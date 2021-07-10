//
//  PrivacySettingsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/07/2021.
//

import SwiftUI

struct PrivacySettingsView: View {
    @State var faceidOn : Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                Background()
                VStack(alignment: .center) {
                    Form {
                        Section {
                            // MARK: Set a passcode
                            NavigationLink(
                                destination: HowToVerifyView()){
                                Image(systemName: "lock.open.fill")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .padding(.trailing, 5)
                                Text("Set Passcode")
                                    .font(.custom("Avenir", size: 17))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                            }
                            
                            // MARK: Change the passcode
                            NavigationLink(
                                destination: HowToVerifyView()){
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .padding(.trailing, 5)
                                Text("Change Passcode")
                                    .font(.custom("Avenir", size: 17))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                    .padding(.leading, 15)
                            }
                            
                            // MARK: FaceID activation
                            HStack {
                                Image(systemName: "faceid")
                                    .font(.system(size: 26))
                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                    .padding(.trailing, 5)
                                Toggle(isOn: $faceidOn) {
                                    Text("Activate FaceID / TouchID")
                                        .font(.custom("Avenir", size: 17))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .padding(.leading, 15)
                                }.onChange(of: faceidOn) { value in
                                    if faceidOn == true {
                                        // Set action to turn on notifications
                                        print("FaceID on")
                                    } else {
                                        // Set action to turn off notifications
                                        print("FaceID off")
                                    }
                                    
                                }.toggleStyle(SwitchToggleStyle(tint: Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)))
                            }
                            
                        }
                        
                    }.foregroundColor(.white)
                }
            }
        }
    }
}

struct PrivacySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacySettingsView()
    }
}
