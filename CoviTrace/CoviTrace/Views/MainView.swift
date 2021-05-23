//
//  MainView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 23/05/2021.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var selectedItem = 0
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
    }
    
    var body: some View {
        TabView(selection: $selectedItem) {
            
            // MARK: Home View Tab
            ContentView()
                .tabItem {
                    if selectedItem == 0 {
                        VStack{
                            Image(systemName: "house")
                            Text("Home")
                        }
                    } else {
                        VStack{
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    }
                }.tag(0)
            
            // MARK: Test Results Tab
            TestResultView()
                .tabItem {
                    if selectedItem == 1 {
                        VStack{
                            Image(systemName: "folder")
                            Text("Test Results")
                        }
                    } else {
                        VStack{
                            Image(systemName: "folder.fill")
                            Text("Test Results")
                        }
                    }
                }.tag(1)
            
            // MARK: Appointments Tab
            AppointmentView()
                .tabItem {
                    if selectedItem == 2 {
                        VStack{
                            Image(systemName: "calendar")
                            Text("Appointments")
                        }
                    } else {
                        VStack{
                            Image(systemName: "calendar")
                            Text("Appointments")
                        }
                    }
                }.tag(2)
            
            // MARK: Check-in Tab
            CheckInView()
                .tabItem {
                    if selectedItem == 3 {
                        VStack{
                            Image(systemName: "scope")
                            Text("Check-In")
                        }
                    } else {
                        VStack{
                            Image(systemName: "scope")
                            Text("Check-In")
                        }
                    }
                }.tag(3)
            
            // MARK: Settings Tab
            InformationView()
                .tabItem {
                    if selectedItem == 4 {
                        VStack{
                            Image(systemName: "line.horizontal.3")
                            Text("Settings")
                        }
                    } else {
                        VStack{
                            Image(systemName: "line.horizontal.3")
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
