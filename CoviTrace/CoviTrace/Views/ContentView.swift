//
//  ContentView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/01/2021.
//

import SwiftUI
import Combine
import Kingfisher
import CoreImage.CIFilterBuiltins
import LocalAuthentication

struct ContentView: View {
    @State private var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State private var current = "house.fill"
    @State private var isHide = false
    @Namespace var animation
    
    @State private var isLoading = false
    
    // MARK: Objects
    @EnvironmentObject var viewModel : AuthViewModel
    @EnvironmentObject var resultsModel : ResultsViewModel
    @EnvironmentObject var vaccModel : FirstDoseVaccViewModel
    @StateObject var appLockModel = AppLockViewModel()
    
    var body: some View {
        ZStack {
            Group {
                if viewModel.userSession != nil {
                    if !appLockModel.isAppLockEnabled {
                        MainView()
                            .environmentObject(appLockModel)
                            .onAppear { UserNetworkingCall() }
                    } else {
                        if appLockModel.isAppUnlocked{
                            MainView()
                                .environmentObject(appLockModel)
                                .onAppear { UserNetworkingCall() }
                        } else {
                            FaceIdLoginView(appLockModel: appLockModel)
                                .background(Color.white)
                        }
                    }
                } else {
                    LandingView()
                }
                
                // MARK: progress loading
                if isLoading {
                    ProgressLoadingView()
                } 
            }
        }
    }
    
    // MARK:  User created networking delay for loading screen
    func UserNetworkingCall() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isLoading = false
        }
    }
}

// MARK: Tab Bar structure
struct TabBarButton: View {
    @Binding var current : String
    var image : String
    var animation : Namespace.ID
    
    var body: some View {
        
        Button(action: {
            withAnimation{current = image}
        }) {
            
            VStack(spacing: 5){
                
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(current == image ? Color(.white) : Color.white.opacity(0.3))
                    .frame(height: 35)
                
                ZStack{
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 4)
                }
            }
        }
    }
}

// MARK: Loading View Structure
struct ProgressLoadingView: View {
    var body: some View {
        ZStack {
            bgGrad()
                .ignoresSafeArea()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color(.white)))
                .scaleEffect(2)
        }
    }
}
