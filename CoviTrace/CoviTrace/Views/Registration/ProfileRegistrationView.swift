//
//  ProfileRegistrationView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 01/10/2021.
//

import SwiftUI
import Firebase

struct ProfileRegistrationView: View {
    @State var lastName = ""
    @State var firstName = ""
    @State var idNumber = ""
    @State var dob = Date()
    @State var verified = "Not Verified"
    @EnvironmentObject var viewModel : AuthViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body: some View {
        ZStack
        {
            Background()
            VStack (alignment: .center){
                Spacer()
                    .frame(height: 30)
                
                // MARK: First Name Text
                CustomTextField(text: $firstName, placeholder: Text("First Name"), imageName: "person")
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                    .textContentType(.none)
                    .keyboardType(.URL)
                
                // MARK: Last Name Text
                CustomTextField(text: $lastName, placeholder: Text("Last Name"), imageName: "person.fill")
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                    .textContentType(.name)
                    .keyboardType(.default)
                
                // MARK: ID Number
                CustomTextField(text: $idNumber, placeholder: Text("ID Number"), imageName: "note.text")
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                    .textContentType(.none)
                    .keyboardType(.numberPad)
                
                // MARK: DOB Text
                DatePicker(selection: $dob, in: ...Date(), displayedComponents: .date) {
                    Text("Choose Date:")
                        .padding(.leading)
                        .foregroundColor(Color(.white)).font(.system(size: 14))
                }.padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                Spacer()
                
                Button(action: {
                    
                    //  move to profile image selection
                }, label: {
                    Text("NEXT")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading, 15)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                    .disabled((lastName != "" && firstName != "" && idNumber != "" && dob != Date()) ? false : true)
                    .opacity((lastName != "" && firstName != "" && idNumber != "" && dob != Date()) ? 1 : 0.6)
                
            }.font(.subheadline)
                .padding(10)
        }.navigationBarTitle("Profile Registration")
            .navigationBarTitleDisplayMode(.inline)
    }
}
