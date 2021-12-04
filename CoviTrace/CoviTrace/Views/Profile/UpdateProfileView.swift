//
//  UpdateProfileView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 30/11/2021.
//

import SwiftUI
import Combine
import Firebase

struct UpdateProfileView: View {
    @State private var idNumber = ""
    @State private var cellNum = ""
    @State private var dob  = Date()
     
    @State private var keyboardHeight: CGFloat = 0
    
    @ObservedObject private var authModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            bgPurple()
            VStack(spacing: 5) {
                HStack {
                    Text("Update information")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("dismiss")
                            .font(.custom("Avenir", size: 10))
                            .foregroundColor(purple)
                    }).frame(width: 40, height: 20)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                
                Spacer()
                    .frame(height: 15)
                
                // MARK: Cell Number Text
                HStack(spacing: 5) {
                    CustomTextField(text: $cellNum, placeholder: Text("Cell number"), imageName: "phone")
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(width: 300, height: 50)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                        .keyboardType(.numbersAndPunctuation)
                    
                    Button(action: {
                        submit_cellNum()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .font(.custom("Avenir", size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    })
                        .frame(width: 50, height: 50)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                        .padding(.top, 2)
                }
                
                // MARK: ID Number
                HStack(spacing: 5) {
                    CustomTextField(text: $idNumber, placeholder: Text("ID Number"), imageName: "note.text")
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(width: 300, height: 50)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(10)
                    
                    Button(action: {
                        submit_idNum()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .font(.custom("Avenir", size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    })
                        .frame(width: 50, height: 50)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                        .padding(.top, 2)
                }
                
                // MARK: DOB
                HStack(spacing: 2){
                    DatePicker(selection: $dob, in: ...Date(), displayedComponents: .date) {
                        HStack {
                            Image(systemName: "calendar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(.white))
                                .padding(.leading, 5)
                            Text("DOB:")
                                .padding(.leading)
                                .font(.custom("Avenir", size: 14).bold())
                                .foregroundColor(Color(.white)).font(.system(size: 14))
                        }
                    }.foregroundColor(Color(.white))
                        .frame(width: 300, height: 50)
                        .background(Color(.white).opacity(0.1)).font(.system(size: 12))
                        .font(.custom("Avenir", size: 12))
                        .cornerRadius(10)
                    
                    Button(action: {
                        submit_dob()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .font(.custom("Avenir", size: 12))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    })
                        .frame(width: 50, height: 50)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                        .padding(.top, 2)
                }
                
                Spacer()
            }
        }
    }
    
    // MARK: Upload to "Vaccinations" DB
    func submit_dob(){
        let db = Firestore.firestore()
        let dob = dateFormatter.string(from: dob)
        db.collection("users").document(authModel.userSession!.uid).setData(["dob": dob], merge: true)
    }
    
    func submit_idNum(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["id_num": idNumber], merge: true)
    }
    
    func submit_cellNum(){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["cell_num": cellNum], merge: true)
    }
}
