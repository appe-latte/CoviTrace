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
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var current = "house.fill"
    @State var isHide = false
    @Namespace var animation
    
    // MARK: Objects
    @EnvironmentObject var viewModel : AuthViewModel
    @EnvironmentObject var resultsModel : ResultsViewModel
    @EnvironmentObject var vaccModel : VaccinationViewModel
    @StateObject var appContext = AppContext()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                if appContext.appUnlocked {
                    MainView()
                } else {
                    FaceIdLoginView(appContext: appContext)
                        .background(Color.white)
                }
            } else {
                LandingView()
            }
        }
    }
}

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
