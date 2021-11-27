//
//  PasscodeEntryView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 26/11/2021.
//

import SwiftUI

struct PasscodeEntryView: View {
    @StateObject var loginData = PhoneVerificationViewModel()
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                
                Spacer()
                
                HStack(spacing: 20) {
                    HStack {
                        
                    }.frame(width: 75, height: 75)
                        .background(Color.white).opacity(0.3)
                        .clipShape(Circle())
                    
                    HStack {
                        
                    }.frame(width: 75, height: 75)
                        .background(Color.white).opacity(0.3)
                        .clipShape(Circle())
                    
                    HStack {
                        
                    }.frame(width: 75, height: 75)
                        .background(Color.white).opacity(0.3)
                        .clipShape(Circle())
                    
                    HStack {
                        
                    }.frame(width: 75, height: 75)
                        .background(Color.white).opacity(0.3)
                        .clipShape(Circle())
                }.padding(.top, 20)
                    .padding(.horizontal, 5)
                
                Spacer()
                    .frame(height: 10)
                
                // MARK: Button Entry
                CustomNumberPad(value: $loginData.mobileNumber, isVerify: false)
            }
        }.navigationTitle("Passcode Entry")
            .navigationBarTitleDisplayMode(.inline)
    }
}
