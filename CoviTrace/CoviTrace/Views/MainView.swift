//
//  MainView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 23/05/2021.
//

import SwiftUI
import Firebase
import FirebaseAuth
import CoreImage.CIFilterBuiltins

struct MainView: View {
    @State private var selectedItem = 0
    @State var showSheetView = false
    @ObservedObject private var viewModel = VaccinationViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var resultsModel = ResultsViewModel()
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
    }
    
    var body: some View {
        TabView(selection: $selectedItem) {
            // MARK: Home View Tab
            ContentView()
                .tabItem {
                    if selectedItem == 0 {
                        VStack{
                            Image(systemName: "person.crop.square")
                                .padding(5)
                            Text("Pass")
                        }
                    } else {
                        VStack{
                            Image(systemName: "person.crop.square.fill")
                                .padding(5)
                                .padding(5)
                            Text("Pass")
                        }
                    }
                }.tag(0)
            
            // MARK: Test Results Tab
            TestResultView()
                .tabItem {
                    if selectedItem == 1 {
                        VStack{
                            Image(systemName: "folder")
                                .padding(5)
                            Text("Test Results")
                        }
                    } else {
                        VStack{
                            Image(systemName: "folder.fill")
                                .padding(5)
                            Text("Test Results")
                        }
                    }
                }.tag(1)
            
            // MARK: Appointments Tab
            AppointmentView()
                .tabItem {
                    if selectedItem == 2 {
                        VStack{
                            Image(systemName: "pin")
                                .padding(5)
                            Text("Appointments")
                        }
                    } else {
                        VStack{
                            Image(systemName: "pin.fill")
                                .padding(5)
                            Text("Appointments")
                        }
                    }
                }.tag(2)
            
            // MARK: Check-in Tab
            NotificationsView()
                .tabItem {
                    if selectedItem == 3 {
                        VStack{
                            Image(systemName: "bell")
                                .padding(5)
                            Text("Notifications")
                        }
                    } else {
                        VStack{
                            Image(systemName: "bell.fill")
                                .padding(5)
                            Text("Notifications")
                        }
                    }
                }.tag(3)
            
            // MARK: Settings Tab
            SettingsView()
                .tabItem {
                    if selectedItem == 4 {
                        VStack{
                            Image(systemName: "gearshape")
                                .padding(5)
                            Text("Settings")
                        }
                    } else {
                        VStack{
                            Image(systemName: "gearshape.fill")
                                .padding(5)
                            Text("Settings")
                        }
                    }
                }.tag(4)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
