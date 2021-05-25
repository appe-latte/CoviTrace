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
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var vaccStatus = ""
    @State var showSecondView = false
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor.init(red: 83 / 255, green: 82 / 255, blue: 116 / 255, alpha: 1.0)
        UITextView.appearance().backgroundColor = .white
        UIDatePicker.appearance().backgroundColor = UIColor.init(red: 46 / 255, green: 153 / 255, blue: 168 / 255, alpha: 1.0)
        UIDatePicker.appearance().tintColor = UIColor.init(red: 83 / 255, green: 82 / 255, blue: 116 / 255, alpha: 1.0)
    }
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                NavigationView {
                    ZStack
                    {
                        // MARK: BACKGROUND COLOUR CODE:
                        Background()
                        
                        // MARK: Profile Summary
                        VStack(alignment: .center){
                            
                            if showSecondView {
                                VStack(alignment:.center){
                                    let fullName = ("\(viewModel.user!.fName)" + " " + "\(viewModel.user!.lName)")
                                    Image(systemName: "person.crop.circle.fill")
                                        .data(url: URL(string: "\(viewModel.user!.profileImageUrl)")!)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 300, height: 200)
                                        .foregroundColor(Color(.white))
                                        .padding()
                                    VStack(alignment: .leading) {
                                        Text("\(fullName)")
                                            .font(.title)
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        
                                        // MARK: DOB
                                        HStack {
                                            Text("DOB: ")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                            Text(viewModel.user!.dob)
                                                .fontWeight(.semibold)
                                                .font(.body)
                                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        }
                                        
                                        // MARK: Verification Status
                                        HStack{
                                            Text("Status: ")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                            Text(viewModel.user!.verified)
                                                .font(.body)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        }
                                        Spacer()
                                    }
                                }
                                .frame(width: 325, height: 325)
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
                        
                        Spacer(minLength: 20)
                        
                        // MARK: Selection Buttons
                        VStack(alignment: .center) {
                            Spacer(minLength: 5)
                            HStack {
                                // MARK: Test Results
                                NavigationLink(
                                    destination: TestResultView()){
                                    VStack {
                                        Image(systemName: "folder")
                                            .font(.largeTitle)
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        Text("Test Results")
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                            .padding(.top, 5)
                                    }
                                }.frame(width: 150, height: 150)
                                .padding(5)
                                .background(Color(.white))
                                .cornerRadius(15)
                                
                                // MARK: Vaccination Card
                                NavigationLink(
                                    destination: VaccCertView()){
                                    VStack {
                                        Image("barcode")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 35, height: 35)
                                        VStack{
                                            Text("Vaccination")
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                                .padding(.top, 5)
                                            Text("Card")
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        }
                                    }
                                }.frame(width: 150, height: 150)
                                .padding(5)
                                .background(Color(.white))
                                .cornerRadius(15)
                            }
                            
                            HStack(alignment: .center) {
                                // MARK: Check-in
                                NavigationLink(
                                    destination: CheckInView()){
                                    VStack {
                                        Image(systemName: "scope")
                                            .font(.largeTitle)
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        Text("Check-In")
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                            .padding(.top, 5)
                                    }
                                }.frame(width: 150, height: 150)
                                .padding(5)
                                .background(Color(.white))
                                .cornerRadius(15)
                                
                                // MARK: Appointment
                                NavigationLink(
                                    destination: AppointmentView()){
                                    VStack {
                                        Image(systemName: "calendar")
                                            .font(.largeTitle)
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        Text("Appointments")
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                            .padding(.top, 5)
                                    }
                                }.frame(width: 150, height: 150)
                                .padding(5)
                                .background(Color(.white))
                                .cornerRadius(15)
                            }
                            
                            HStack {
                                // MARK: Settings
                                NavigationLink(
                                    destination: InformationView()){
                                    HStack {
                                        Image(systemName: "line.horizontal.3")
                                            .font(.largeTitle)
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        Text("Settings")
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                            .padding(.leading, 15)
                                    }
                                }.frame(width: 315, height: 30)
                                .padding(5)
                                .background(Color(.white))
                                .cornerRadius(10)
                            }
                        }.padding()
                        Spacer()
                        
                    }
                    .navigationBarHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
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
