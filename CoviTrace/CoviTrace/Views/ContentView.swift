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
    //    @EnvironmentObject var viewModel : AuthViewModel
    //    @EnvironmentObject var resultsModel : ResultsViewModel
    
    @ObservedObject var viewModel = AuthViewModel()
    @ObservedObject var resultsModel = ResultsViewModel()
    //    @ObservedObject var boosterModel = BoosterShotViewModel()
    @State private var vaccStatus = ""
    @State private var patientNumber = ""
    @State var showSecondView = false
    @State var showSheetView = false
    @State var selectedItem = 0
    @State var showCovidPassSheetView = false
    
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
                NavigationView {
                    ZStack
                    {
                        // MARK: BACKGROUND COLOUR CODE:
                        Background()
                        
                        ScrollView(.vertical, showsIndicators: false) { // scrollview
                            
                            // MARK: Profile Summary
                            VStack(alignment: .center){
                                
                                if showSecondView {
                                    VStack(alignment:.center){
                                        
                                        let fullName = ("\(viewModel.user!.fName)" + " " + "\(viewModel.user!.lName)")
                                        
                                        // MARK: Profile Image
                                        Image(systemName: "person.crop.circle.fill")
                                            .data(url: URL(string: "\(viewModel.user!.profileImageUrl)")!)
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 300, height: 200)
                                            .foregroundColor(Color(.white))
                                            .padding(5)
                                        
                                        // MARK: User Name
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text("\(fullName)")
                                                .font(.title)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                            
                                            // MARK: Patient Number
                                            HStack{
                                                Text("ID Number: ")
                                                    .font(.body)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                Text(viewModel.user!.patientNumber)
                                                    .font(.body)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                            }
                                            
                                            // MARK: Verification Status
                                            HStack{
                                                Text("Profile Status: ")
                                                    .font(.body)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                Text(viewModel.user!.verified)
                                                    .font(.body)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                            }
                                            
                                            // MARK: Vaccination Information
                                            HStack {
                                                NavigationLink(
                                                    destination: VaccCertView()){
                                                        HStack {
                                                            Image(systemName: "qrcode")
                                                                .font(.system(size: 24))
                                                                .foregroundColor(Color(.white))
                                                            Text("View Covid Pass")
                                                                .fontWeight(.semibold)
                                                                .foregroundColor(Color(.white))
                                                                .padding(.trailing, 30)
                                                        }
                                                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .center)
                                                    .padding(5)
                                                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                    .cornerRadius(10)
                                            }
                                            
                                            // MARK: View Cards
                                            HStack {
                                                NavigationLink(
                                                    destination: UploadInformationView()){
                                                        HStack {
                                                            Image(systemName: "photo")
                                                                .font(.system(size: 24))
                                                                .foregroundColor(Color(.white))
                                                            Text("View Certificate")
                                                                .fontWeight(.semibold)
                                                                .foregroundColor(Color(.white))
                                                                .padding(.trailing, 25)
                                                        }
                                                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .center)
                                                    .padding(5)
                                                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                    .cornerRadius(10)
                                            }
                                            
                                            // MARK: Venue Check-In
                                            HStack {
                                                NavigationLink(
                                                    destination: CheckInView()){
                                                        HStack {
                                                            Image(systemName: "barcode")
                                                                .font(.system(size: 24))
                                                                .foregroundColor(Color(.white))
                                                            Text("Venue Check-in")
                                                                .fontWeight(.semibold)
                                                                .foregroundColor(Color(.white))
                                                                .padding(.trailing, 25)
                                                        }
                                                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .center)
                                                    .padding(5)
                                                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                    .cornerRadius(10)
                                            }
                                            
                                            // MARK: View Test Results
                                            HStack {
                                                NavigationLink(
                                                    destination: TestResultView()){
                                                        HStack {
                                                            Image(systemName: "tray.fill")
                                                                .font(.system(size: 24))
                                                                .foregroundColor(Color(.white))
                                                            Text("Test Results")
                                                                .fontWeight(.semibold)
                                                                .foregroundColor(Color(.white))
                                                                .padding(.trailing, 50)
                                                        }
                                                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .center)
                                                    .padding(5)
                                                    .background(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                    .cornerRadius(10)
                                            }
                                            
                                            // MARK: View Previous Check-ins
                                            HStack {
                                                NavigationLink(
                                                    destination: CheckInView()){
                                                        HStack {
                                                            Image(systemName: "tray.fill")
                                                                .font(.system(size: 24))
                                                                .foregroundColor(Color(.white))
                                                            Text("Venue Check-ins")
                                                                .fontWeight(.semibold)
                                                                .foregroundColor(Color(.white))
                                                                .padding(.trailing, 10)
                                                        }
                                                    }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250, minHeight: 0, maxHeight: 50, alignment: .center)
                                                    .padding(5)
                                                    .background(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                                    .cornerRadius(10)
                                            }
                                        }
                                    }
                                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 725)
                                    .background(Color(.white))
                                    .cornerRadius(15)
                                    .padding(5)
                                }
                                
                                Spacer(minLength: 5)
                            }.onAppear() {
                                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                                    withAnimation {
                                        self.showSecondView = true
                                    }
                                }
                            }
                        }
                        
                        Spacer(minLength: 20)
                        
                    }
                    .navigationBarHidden(false)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        
                        // MARK: Log Vaccinations / Test Results
                        ToolbarItem(placement: .navigationBarLeading) {
                            HStack {
                                NavigationLink(
                                    destination: UploadInformationView()){
                                        HStack {
                                            Image(systemName: "plus")
                                                .font(.system(size: 24))
                                                .foregroundColor(Color(.white))
                                        }
                                    }
                            }
                        }
                        
                        // MARK: Settings Page
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                NavigationLink(
                                    destination: SettingsView()){
                                        HStack {
                                            Image(systemName: "gearshape")
                                                .font(.system(size: 24))
                                                .foregroundColor(Color(.white))
                                        }
                                    }
                            }
                        }
                    }
                }
            } else {
                LandingView()
            }
        }
    }
    
}

extension Image {
    func data(url: URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!).resizable()
        }
        return self.resizable()
    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
