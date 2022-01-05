//
//  AccountDeletionView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/11/2021.
//

import SwiftUI
import Combine
import FirebaseAuth
import AlertToast
import FirebaseFirestore

struct AccountDeletionView: View {
    @State var dob = ""
    
    // MARK: Alert
    @State var showDeleteAlert = false
    @State private var showToastAlert : Bool = false
    @State private var errTitle = ""
    @State private var errMessage = ""
    
    // MARK: Objects
    @EnvironmentObject private var appLockModel : AppLockViewModel
    @EnvironmentObject var authModel : AuthViewModel
    
    var isAppLockEnabled = false
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                    // MARK: Delete Account
                    Section(header: Text("Permanently Delete Account")) {
                        HStack {
                            Button(action: {
                                self.showDeleteAlert = true
                            }, label: {
                                HStack {
                                    Image("trash")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(1)
                                    Text("Delete My Account")
                                        .font(.custom("Avenir", size: 15))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                                        .padding(.leading, 15)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .scaledToFit()
                                        .font(Font.title.weight(.semibold))
                                        .foregroundColor(Color(.gray)).opacity(0.5)
                                        .frame(width: 13, height: 13)
                                }
                            }).alert(isPresented:$showDeleteAlert) {
                                Alert(
                                    title: Text("Are you sure you want to delete your account?"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        deleteUser()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                        }
                        Text("This action permanently deletes your account and removes all of your information from our servers.")
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .font(.custom("Avenir", size: 12).bold())
                    }
                }
            }.background(bgPurple())
        }
    }
    
    // MARK: Delete User functiona
    func deleteUser() {
        let userId = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("users").document(userId).delete() { err in
            if let err = err  {
                print("Error: \(err)")
            } else {
                Auth.auth().currentUser!.delete { error in
                    if let error = error {
                        self.errTitle = "Error!"
                        self.errMessage = "Error deleting the user: \(error)"
                        self.showToastAlert = true
                    } else {
                        self.errTitle = "Account Deleted"
                        self.errMessage = "Your user account has successfully been deleted"
                        self.showToastAlert = true
                        authModel.signOut()
                    }
                }
            }
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
