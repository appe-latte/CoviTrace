//
//  CoviTraceApp.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
//

import SwiftUI
import Firebase
import Combine

@main
struct CoviTraceApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(AuthViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(.light)
        }
    }
}
