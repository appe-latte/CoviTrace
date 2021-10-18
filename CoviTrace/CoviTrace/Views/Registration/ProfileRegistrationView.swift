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
    @State var userEmail = ""
    @State var userPassword = ""
    @State var confirmPassword = ""
    @State var verified = "Not Verified"
    @EnvironmentObject var viewModel : AuthViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack
        {
            Background()
            VStack (alignment: .center){
                
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
                CustomTextField(text: $idNumber, placeholder: Text("ID Number"), imageName: "number")
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                    .textContentType(.none)
                    .keyboardType(.numberPad)
                
                // MARK: User Email Text
                CustomTextField(text: $userEmail, placeholder: Text("Email"), imageName: "envelope")
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                    .keyboardType(.emailAddress).autocapitalization(.none)
                
                // MARK: User Password Text
                CustomSecureTextField(text: $userPassword, placeholder: Text("Password"))
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Confirm User Password Text
                CustomSecureTextField(text: $confirmPassword, placeholder: Text("Confirm password"))
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                Spacer()
                
                // MARK: moves to mobile number OTP verification
                
                Button(action: {
                    
                }, label: {
                    Text("Next")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading, 15)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                
            }.font(.subheadline)
                .padding(10)
        }
    }
}

struct ProfileRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRegistrationView()
    }
}
