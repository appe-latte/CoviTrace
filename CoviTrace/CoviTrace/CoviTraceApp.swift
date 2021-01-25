//
//  CoviTraceApp.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
//

import SwiftUI

@main
struct CoviTraceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SymptomPageView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
