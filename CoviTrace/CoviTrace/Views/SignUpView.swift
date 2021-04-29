//
//  SignUpView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI
import Combine
import UIKit

struct SignUpView: View {
    @State var lastName = ""
    @State var firstName = ""
    @State var userEmail = ""
    @State var userPassword = ""
    @State private var keyboardHeight: CGFloat = 0
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    @State var showImagePicker = false
    @EnvironmentObject var viewModel : AuthViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func loadImage(){
        guard let selectedImage = selectedUIImage else {return}
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        NavigationView{
            ZStack
            {
                Background()
                VStack (alignment: .center){
                    VStack(alignment:.center){
                        Button(action: {showImagePicker.toggle()}, label: {
                            ZStack {
                                
                                if let image = image {
                                    image
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 150, height: 150)
                                        .padding(.top, 80)
                                        .padding(.bottom, 16)
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .renderingMode(.template)
                                        .scaledToFill()
                                        .frame(width: 150, height: 150)
                                        .foregroundColor(.white)
                                        .padding(.top, 80)
                                        .padding(.bottom, 16)
                                }
                            }
                        }).sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                            ImagePicker(image: $selectedUIImage)
                        })
                        Text("Add Profile Image")
                            .foregroundColor(.white)
                            .padding()
                        
                        Spacer()
                    }
                    Spacer()
                    // MARK: First Name Text
                    CustomTextField(text: $firstName, placeholder: Text("First Name"), imageName: "person")
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading, 15)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(15)
                        .textContentType(.none)
                        .keyboardType(.URL)
                    
                    // MARK: Last Name Text
                    CustomTextField(text: $lastName, placeholder: Text("Last Name"), imageName: "person")
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading, 15)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(15)
                        .textContentType(.name)
                        .keyboardType(.default)
                    
                    // MARK: User Email Text
                    CustomTextField(text: $userEmail, placeholder: Text("Email"), imageName: "envelope")
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading, 15)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(15)
                        .keyboardType(.emailAddress).autocapitalization(.none)
                    
                    // MARK: User Password Text
                    CustomSecureTextField(text: $userPassword, placeholder: Text("Password"))
                        .padding(5)
                        .foregroundColor(Color(.white))
                        .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 50).padding(.leading, 15)
                        .background(Color(.white).opacity(0.1))
                        .cornerRadius(15)

                    // MARK: "Sign Up" Button
                    Button(action: {
                        guard let image = selectedUIImage else {return}
                        viewModel.userSignUp(firstName: firstName, lastName: lastName, email: userEmail, password: userPassword, profileImage: image)
//                        viewModel.userSignUp(firstName: firstName, lastName: lastName, email: userEmail, password: userPassword)
                    }, label: {
                        Text("Sign Up")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 300, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading, 15)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                    
                    // MARK: "Existing User"
                    NavigationLink(
                        destination: LoginView()){
                        Text("Existing User?")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(Color(.white))
                            .padding(.top, 2)
                    }
                }.font(.subheadline)
                .padding(10)
                .padding(.bottom, keyboardHeight)
                .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
            }
        }.navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
