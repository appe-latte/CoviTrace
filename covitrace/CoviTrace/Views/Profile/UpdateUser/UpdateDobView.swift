//
//  UpdateDobView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 10/12/2021.
//

import SwiftUI
import Firebase
import AlertToast
import FirebaseFirestore

struct UpdateDobView: View {
    @State private var isPresented = true
    @State var dob = Date()
    
    // MARK: Alert
    @State private var showToastAlert : Bool = false
    @State private var errTitle = ""
    @State private var errMessage = ""
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var authModel = AuthViewModel()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Text("Update Date of Birth")
                        .foregroundColor(purple)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("close-p")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }).padding(5)
                        .clipShape(Circle())
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                
                // MARK: Test Reference Number TextField
                HStack {
                    Text("Select DOB:")
                        .padding(.leading)
                        .font(.custom("Avenir", size: 14).bold())
                        .foregroundColor(purple).font(.system(size: 12))
                    DatePicker(selection: $dob, in: ...Date(), displayedComponents: .date) {}
                }.foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .font(.system(size: 12))
                    .font(.custom("Avenir", size: 12))
                
                // MARK: Update DOB
                Button(action: {
                    submit_dob()
                    showToastAlert = true
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Text("Submit")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                }).buttonStyle(purpleButtonLong())
                    .padding(.top, 2)
                
                Spacer()
            }.padding(.top, 15)
                .toast(isPresenting: $showToastAlert){
                    AlertToast(displayMode: .alert, type: .complete(green), title: Optional(errTitle), subTitle: Optional(errMessage))
                }
        }.background(bgWhite())
            .accentColor(purple)
    }
    
    func submit_dob(){
        let db = Firestore.firestore()
        let dob_update = dateFormatter.string(from: dob)
        db.collection("users").document(authModel.userSession!.uid).setData(["dob": dob_update], merge: true)
        
        self.errTitle = "Success!"
        self.errMessage = "DOB has successfully been updated"
        self.showToastAlert = true
    }
}
