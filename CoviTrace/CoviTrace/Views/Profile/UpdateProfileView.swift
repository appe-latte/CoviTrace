//
//  UpdateProfileView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 30/11/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct UpdateProfileView: View {
    @State private var idNumber = ""
    @State private var cellNum = ""
    @State private var dob  = Date()
    
    @State private var keyboardHeight: CGFloat = 0
    
    @EnvironmentObject var authModel : AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            Background()
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
                
                // MARK: Cell Number Text
                CustomTextField(text: $cellNum, placeholder: Text("Cell number"), imageName: "phone")
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                    .keyboardType(.numbersAndPunctuation)
                
                // MARK: ID Number
                CustomTextField(text: $idNumber, placeholder: Text("ID Number"), imageName: "note.text")
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(10)
                
                // MARK: DoB
                DatePicker(selection: $dob, in: ...Date(), displayedComponents: .date) {
                    Text("DOB:")
                        .padding(.leading)
                        .font(.custom("Avenir", size: 14).bold())
                        .foregroundColor(Color(.white)).font(.system(size: 14))
                }.foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1)).font(.system(size: 12))
                    .font(.custom("Avenir", size: 14))
                    .cornerRadius(10)
                
                // MARK: "Submit" button
                Button(action: {
                    upload_data()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Submit")
                        .font(.custom("Avenir", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                })
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(10)
                    .padding(.top, 2)
            }
        }
    }
    
    // MARK: Upload to "Vaccinations" DB
    func upload_data(){
        let db = Firestore.firestore()
        let dob = dateFormatter.string(from: dob)
        db.collection("users").document(authModel.userSession!.uid).setData(["cell_num": cellNum, "id_num": idNumber, "dob": dob], merge: true)
    }
}
