//
//  PhoneVerificationView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 23/09/2021.
//

import SwiftUI
import Firebase

struct PhoneVerificationView: View {
    @State var cellNum = ""
    @State var countryCode = ""
    let countryCodeType = ["code", "+27", "+263", "+266", "+267", "+268"]
//    let countryCodeType = ["code", "+27", "+263"]
    
    var body: some View {
        ZStack {
            Background()
            
            VStack(spacing: 10){
                
                Spacer()
                    .frame(height: 50)
                
                Text("Enter your cellphone number for OTP verification and to complete the registration process.")
                    .font(.system(size: 14))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 5)
                
                // MARK: Cellphone Number + Country Code
                HStack{
                    Picker("code", selection: $countryCode) {
                        ForEach(countryCodeType, id: \.self) {
                            Text($0).bold()
                        }
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 80, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.black).opacity(0.1))
                        .cornerRadius(10)
                    }.frame(width:80)
                    
                    TextField("Cell number", text: $cellNum)
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(.black).opacity(0.1))
                        .cornerRadius(10)
                        .keyboardType(.numberPad)
                }.padding(.horizontal, 15)
                
                Spacer()
                
                // MARK: "Register" Button
                Button(action: {
                    
                    // add code here to verify number and upload details to "users" Firebase database.
                    
                }, label: {
                    Text("Register")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(10)
                    .padding(.top, 2)
                    .disabled((countryCode != "" && cellNum != "") ? false : true)
                    .opacity((countryCode != "" && cellNum != "") ? 1 : 0.6)
            }
        }.accentColor(Color.white)
    }
}
