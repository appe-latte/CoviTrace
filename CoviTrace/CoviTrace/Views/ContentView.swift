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

struct ContentView: View {
    @State var top = UIApplication.shared.windows.first?.safeAreaInsets.top
    @State var current = "house.fill"
    @Namespace var animation
    
    @State var isHide = false
    
    @EnvironmentObject var viewModel : AuthViewModel
    @EnvironmentObject var resultsModel : ResultsViewModel
    @EnvironmentObject var vaccModel : VaccinationViewModel
    
    @StateObject var appContext = AppContext()
    
    init() {
        let barTintColor = UINavigationBarAppearance()
        barTintColor.configureWithOpaqueBackground()
        barTintColor.backgroundColor = UIColor.init(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        barTintColor.titleTextAttributes = [.foregroundColor: UIColor.white]
        barTintColor.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().backgroundColor = UIColor.init(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        UITextView.appearance().backgroundColor = .white
        UIDatePicker.appearance().backgroundColor = UIColor.init(red: 46 / 255, green: 153 / 255, blue: 168 / 255, alpha: 1.0)
        UIDatePicker.appearance().tintColor = UIColor.init(red: 83 / 255, green: 82 / 255, blue: 116 / 255, alpha: 1.0)
        UINavigationBar.appearance().scrollEdgeAppearance = barTintColor
        UINavigationBar.appearance().standardAppearance = barTintColor
    }
    
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
