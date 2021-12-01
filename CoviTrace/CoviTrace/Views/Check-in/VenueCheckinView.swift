//
//  VenueCheckinView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 20/11/2021.
//

import SwiftUI

struct VenueCheckinView: View {
    @State private var fullName = ""
    @State private var cellNum = ""
    @State private var email = ""
    
    // MARK: Objects
    @ObservedObject private var viewModel = FirstDoseVaccViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            Background()
            VStack {
                VStack{
                    Text("Venue Check-in")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .padding(.top, 15)
                
                VStack {
                    // MARK: User Full name
                    SimpleTextField(text: $fullName, placeholder: Text("Enter full name"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                        .disabled(true)
                    
                    // MARK: Cell Number
                    SimpleTextField(text: $cellNum, placeholder: Text("Enter cellphone number"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                        .disabled(true)
                    
                    // MARK: Venue Email
                    SimpleTextField(text: $email, placeholder: Text("Enter email"))
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    // MARK: "Submit" button
                    Button(action: {
                        // <-- add code to POST
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Check-in")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    })
                        .frame(width: 150, height: 50)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                        .padding(.top, 2)
                        .disabled((fullName != "" && cellNum != "" ) ? false : true)
                    
                }.padding(.top, 10)
                Spacer()
            }
        }.navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
    }
}
