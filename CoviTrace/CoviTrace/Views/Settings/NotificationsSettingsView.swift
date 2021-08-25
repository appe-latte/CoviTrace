//
//  NotificationsSettingsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 19/08/2021.
//

import SwiftUI

struct NotificationsSettingsView: View {
    @State var notifOn : Bool = false
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                HStack {
                    Image(systemName: "app.badge")
                        .font(.system(size: 26))
                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        .padding(.trailing, 5)
                    Toggle(isOn: $notifOn) {
                        Text("Notifications")
                            .font(.custom("Avenir", size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        //                                    .padding(.leading, 15)
                    }.onChange(of: notifOn) { value in
                        if notifOn == true {
                            // Set action to turn on notifications
                            print("Notifications On")
                        } else {
                            // Set action to turn off notifications
                            print("Notifications Off")
                        }
                        
                    }.toggleStyle(SwitchToggleStyle(tint: Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)))
                }
            }
        }
    }
}

struct NotificationsSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsSettingsView()
    }
}
