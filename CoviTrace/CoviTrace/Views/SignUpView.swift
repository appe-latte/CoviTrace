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
    @State var idNumber = ""
    @State var userEmail = ""
    @State var userPassword = ""
    @State var userCellNum = ""
    @State var verified = "not verified"
    @State private var keyboardHeight: CGFloat = 0
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    @State var showImagePicker = false
    @EnvironmentObject var viewModel : AuthViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
    
    init() {
        self.listenForKeyboardNotifications()
    }
    
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
                    
                    // MARK: Profile Image selection
                    VStack(alignment:.center){
                        Button(action: {showImagePicker.toggle()}, label: {
                            ZStack {
                                
                                if let image = image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 100, height: 100)
                                        .padding(.vertical, 5)
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .renderingMode(.template)
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 5)
                                }
                            }
                        }).sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                            ImagePicker(image: $selectedUIImage)
                        })
                        Text("Add Profile Image")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .padding(5)
                    }.padding(.bottom, 5)
                    
                    VStack {
                        
                        // MARK: First Name Text
                        CustomTextField(text: $firstName, placeholder: Text("First Name"), imageName: "person")
                            .padding(5)
                            .foregroundColor(Color(.white))
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                            .background(Color(.white).opacity(0.1))
                            .cornerRadius(10)
                        //                            .offset(y: -self.keyboardHeightHelper.keyboardHeight)
                        
                        // MARK: Last Name Text
                        CustomTextField(text: $lastName, placeholder: Text("Last Name"), imageName: "person.fill")
                            .padding(5)
                            .foregroundColor(Color(.white))
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                            .background(Color(.white).opacity(0.1))
                            .cornerRadius(10)
                        //                            .offset(y: -self.keyboardHeightHelper.keyboardHeight)
                        
                        // MARK: ID Number
                        CustomTextField(text: $idNumber, placeholder: Text("ID Number"), imageName: "note.text")
                            .padding(5)
                            .foregroundColor(Color(.white))
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                            .background(Color(.white).opacity(0.1))
                            .cornerRadius(10)
                        //                            .offset(y: -self.keyboardHeightHelper.keyboardHeight)
                        
                        // MARK: User Email Text
                        CustomTextField(text: $userEmail, placeholder: Text("Email"), imageName: "envelope")
                            .padding(5)
                            .foregroundColor(Color(.white))
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                            .background(Color(.white).opacity(0.1))
                            .cornerRadius(10)
                        //                            .offset(y: -self.keyboardHeightHelper.keyboardHeight)
                        
                        // MARK: User Password Text
                        CustomSecureTextField(text: $userPassword, placeholder: Text("Password"))
                            .padding(5)
                            .foregroundColor(Color(.white))
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                            .background(Color(.white).opacity(0.1))
                            .cornerRadius(10)
                        //                            .offset(y: -self.keyboardHeightHelper.keyboardHeight)
                        
                    }.font(.subheadline)
                        .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
                    
                    Spacer()
                    
                    // MARK: "Sign Up" Button
                    Button(action: {
                        guard let image = selectedUIImage else {return}
                        viewModel.userRegistration(email: userEmail, userPwd: userPassword, firstName: firstName, lastName: lastName, profileImage: image, verified: verified, idNumber: idNumber)
                    }, label: {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                    
                    // MARK: "Existing User"
                    NavigationLink(
                        destination: LoginView()){
                            Text("Existing User?")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(Color(.white))
                                .padding(.top, 2)
                        }
                }
            }
        }.navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
    
    // MARK: Keyboard Height listener
    private func listenForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            guard let userInfo = notification.userInfo,
                  let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            self.keyboardHeight = keyboardRect.height
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            self.keyboardHeight = 2
        }
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
