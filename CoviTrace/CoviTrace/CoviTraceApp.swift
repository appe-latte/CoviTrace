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
    @StateObject var appContext = AppContext()
    
    
    init(){
        FirebaseApp.configure()
    }
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            //            ContentView().environmentObject(AuthViewModel())
            ////                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            //                .preferredColorScheme(.light)
            //        }
            //
            ZStack {
                if appContext.appUnlocked {

                    ContentView().environmentObject(AuthViewModel())
                    //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .preferredColorScheme(.light)
                } else {
                    FaceIdLoginView(appContext: appContext)
                        .background(Color.white)
                }
            }
        }
        }
    }
