//
//  AccountDeletionView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 15/12/2021.
//

import SwiftUI
import AlertToast
import FirebaseAuth
import FirebaseFirestore

struct AccountDeletionView: View {
    @State var accountDeletionModal_shown = false
    
    @EnvironmentObject var authModel : AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Alert
    @State private var showToastAlert : Bool = false
    @State private var errTitle = ""
    @State private var errMessage = ""
    
    var body: some View {
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        let green = Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)
        
        ZStack {
            VStack {
                HStack {
                    Text("Delete My Account")
                        .foregroundColor(purple)
                        .fontWeight(.semibold)
                    
                    Spacer()
                        .frame(height: 15)
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                
                Spacer()
                    .frame(height: 30)
                
                // MARK: "Delete" button
                VStack(spacing: 10) {
                    Button(action: {
                        self.deleteUser()
                        showToastAlert = true
                    }, label: {
                        Text("Delete")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }).frame(width: 150, height: 50)
                        .background(Color.red)
                        .cornerRadius(10)
                    
                    Text("NOTE: This action permanently deletes your account and removes all of your information from our servers. Once this action is complete be advised that it cannot be reversed and will require that you setup a new account.")
                        .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        .font(.custom("Avenir", size: 12).bold())
                }
                Spacer()
            }
        }.toast(isPresenting: $showToastAlert){
            AlertToast(displayMode: .alert, type: .complete(green), title: Optional(errTitle), subTitle: Optional(errMessage))
        }
    }
}
