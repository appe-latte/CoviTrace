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
    @State private var patientNumber = ""
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
                                            Text("Profile: ")
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
                        
                        // MARK: Options
                        VStack(alignment: .center) {
                            Spacer(minLength: 5)
                            // MARK: Check-in
                            HStack {
                                NavigationLink(
                                    destination: CheckInView()){
                                    HStack {
                                        Image(systemName: "mappin.circle")
                                            .font(.system(size: 24))
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                        Text("Venue Check-in")
                                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                                            .fontWeight(.semibold)
                                    }
                                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                .padding(5)
                                .background(Color(.white))
                                .cornerRadius(10)
                            }
       
                            // MARK: Vaccination Information
                            HStack {
                                NavigationLink(
                                    destination: VaccCertView()){
                                    HStack {
                                        Image(systemName: "qrcode")
                                            .font(.system(size: 24))
                                            .foregroundColor(Color(.white))
                                    Text("Vaccination Pass")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(.white))
                                    }
                                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                                .padding(5)
                                .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
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
