//
//  LoginView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI
import os
import Combine
import FirebaseAuth
import CountryPicker
import AlertToast

struct LoginView: View {
    @State private var isLoggedIn : Bool = false
    @State var showPwdResetSheetView = false
    @State var showSignUpSheetView = false
    
    // MARK: OTP
    @State var showOTPSheetView = false
    @State var phoneNumber = ""
    @State private var verificationID = ""
    @State var showProgressView = false
    
    // MARK: Country Picker
    @State private var country: Country?
    @State private var showCountryPicker = false
    
    // MARK: Alert
    @State private var showToastAlert : Bool = false
    @State private var errTitle = ""
    @State private var errMessage = ""
    
    // MARK: Objects
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        ZStack {
            VStack (spacing: 2){
                HStack {
                    Text("Validate Number")
                        .foregroundColor(purple)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    //                    Button(action: {
                    //                        self.presentationMode.wrappedValue.dismiss()
                    //                    }, label: {
                    //                        Image("close-p")
                    //                            .resizable()
                    //                            .frame(width: 30, height: 30)
                    //                    }).padding(5)
                    //                        .clipShape(Circle())
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                
                // MARK: Phone Number entry
                HStack(spacing: 16){
                    Button {
                        self.showCountryPicker = true
                    } label: {
                        Text(country != nil ? "\(country!.isoCode.getFlag())+\(country!.phoneCode)" : "\("ZA".getFlag())+27").font(.custom("Avenir", size: 18))
                    }.sheet(isPresented: $showCountryPicker) {
                        CountryPickerView(country: $country)
                    }.frame(width: 65, height: 30)
                        .foregroundColor(purple)
                        .padding(.leading, 5)
                    
                    TextField("Enter Cellphone Number", text: $phoneNumber)
                        .font(.custom("Avenir", size: 14).bold())
                        .keyboardType(.numberPad)
                    
                }.padding(5)
                    .foregroundColor(purple)
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50)
                    .padding(.leading,5)
                    .background(purple.opacity(0.1))
                    .cornerRadius(10)
                
                Spacer()
                
                if self.showProgressView {
                    VStack(spacing: 1){
                        ProgressView()
                            .frame(width: 60, height: 60)
                            .progressViewStyle(CircularProgressViewStyle(tint: purple))
                            .scaleEffect(2)
                        
                        Text("Please Wait")
                            .foregroundColor(purple)
                            .font(.custom("Avenir", size: 12).bold())
                    }.frame(width: 80, height: 100)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                // MARK: "Login" Button
                Button(action: {
                    self.showProgressView = true
                    self.sendOTP()
                }, label: {
                    Text("Verify")
                        .font(.custom("Avenir", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }).buttonStyle(purpleButtonLong())
                    .padding(.top, 2)
                    .padding(.bottom, 10)
                    .disabled((phoneNumber != "") ? false : true)
                    .opacity((phoneNumber != "") ? 1 : 0.6)
                    .alert(isPresented: $viewModel.isError, content: {
                        Alert(title: Text("Login Error"), message: Text(viewModel.errorMsg)
                                .environmentObject(self.viewModel) as? Text)
                    })
                    .sheet(isPresented: $showOTPSheetView, onDismiss: {
                        if viewModel.userSession != nil {
                            UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                        } else {
                            self.showProgressView = false
                        }
                    }) {
                        PhoneOTPView(verificationID: $verificationID).environmentObject(self.viewModel)
                    }
            }.toast(isPresenting: $showToastAlert){
                AlertToast(displayMode: .alert, type: .error(.red), title: Optional(errTitle), subTitle: Optional(errMessage))
            }
        }
        .background(bgWhite())
        .accentColor(purple)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
    }
    
    // MARK: Send OTP method
    func sendOTP() {
        var countryCode = "+27"
        if country != nil {
            countryCode = "+\(country!.phoneCode)"
        }
        let phoneNo = "\(countryCode)\(phoneNumber)"
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNo, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print("======= Phone auth error :: \(error.localizedDescription)")
                    // self.showMessagePrompt(error.localizedDescription)
                    self.errTitle = "Error"
                    self.errMessage = "\(error.localizedDescription)"
                    self.showToastAlert = true
                    return
                }
                
                if let mVerificationID = verificationID {
                    print(mVerificationID)
                    self.verificationID = mVerificationID
                    self.showOTPSheetView = true
                }
            }
    }
}

