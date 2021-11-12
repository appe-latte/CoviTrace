//
//  CoviTraceApp.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
//

import SwiftUI
import Firebase
import Combine
import LocalAuthentication
import UserNotifications

@main
struct CoviTraceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init(){
        FirebaseApp.configure()
    }
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
                        ContentView().environmentObject(AuthViewModel())
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                            .preferredColorScheme(.light)
        }
    }
}
