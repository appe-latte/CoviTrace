//
//  SignUpView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI
import Combine
import UIKit
import FirebaseAuth

struct SignUpView: View {
    @State private var lastName = ""
    @State private var firstName = ""
    @State private var phoneNumber = ""
    @State private var idNumber = "-"
    @State private var email = ""
    @State private var userPassword = ""
    @State private var cellNum = "-"
    @State private var regCountry = "-"
    @State private var idType = "-"
    @State private var dob = "-"
    @State private var verified = "Not Verified"
    
    @State private var keyboardHeight: CGFloat = 0
    
    // MARK: Image Picker
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    @State var showImagePicker = false
    @State var selectedImage: UIImage = UIImage()
    
    // MARK: Objects
    @EnvironmentObject var viewModel : AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var keyboardHeightHelper = KeyboardHeightHelper()
    
    @State var showOTPSheetView = false
    
    init() {
        self.listenForKeyboardNotifications()
        UINavigationBar.appearance().barTintColor = UIColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
        UINavigationBar.appearance().tintColor = UIColor(Color.white)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func loadImage(){
        guard let selectedImage = selectedUIImage else {return}
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("User Registration")
                        .foregroundColor(purple)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    //                    Button(action: {
                    //                        self.presentationMode.wrappedValue.dismiss()
                    //                    }, label: {
                    //                        Image("close-p")
                    //                            .resizable()
                    //                            .frame(width: 30, height: 30)
                    //                    }).padding(5)
                    //                        .clipShape(Circle())
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                
                ScrollView(.vertical, showsIndicators: false) {
                    Group {
                        
                        // MARK: Profile Image selection
                        VStack(alignment:.center){
                            Button(action: {showImagePicker.toggle()}, label: {
                                VStack {
                                    
                                    if let image = image {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 125, height: 125)
                                            .padding(.vertical, 5)
                                    } else {
                                        VStack {
                                            Text("+ profile")
                                                .font(.system(size: 12))
                                                .foregroundColor(purple)
                                            Text("picture")
                                                .font(.system(size: 12))
                                                .foregroundColor(purple)
                                        }.frame(width: 125, height: 125)
                                            .padding(.vertical, 5)
                                            .background(purple.opacity(0.1))
                                            .clipShape(Circle())
                                    }
                                }
                            }).sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                                ImagePicker(image: $selectedUIImage)
                            })
                        }
                        
                        // MARK: Textfields
                        VStack(spacing: 5) {
                            
                            // MARK: First Name Text
                            CustomTextField(text: $firstName, placeholder: Text("First Name"), imageName: "user-2")
                                .padding(5)
                                .foregroundColor(purple)
                                .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                                .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
                            
                            // MARK: Last Name Text
                            CustomTextField(text: $lastName, placeholder: Text("Last Name"), imageName: "user-2")
                                .padding(5)
                                .foregroundColor(purple)
                                .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                                .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
                            
                            // MARK: User Email Text
                            CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                                .padding(5)
                                .foregroundColor(purple)
                                .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                                .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
                            
                            Text("* Please ensure that information is entered in all the available fields and that a profile image is selected.")
                                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 60, alignment: .center)
                                .font(.custom("Avenir", size: 10).bold())
                                .foregroundColor(purple)
                                .multilineTextAlignment(.leading)
                                .lineLimit(10)
                            
                            Spacer()
                            
                        }.font(.subheadline)
                    }
                }
                Spacer()
                
                // MARK: "Sign Up" Button
                Button(action: {
                    guard let image = selectedUIImage else {return}
                    viewModel.saveUserInfo(email: email, firstName: firstName, lastName: lastName, profileImage: image, verified: verified, idNumber: idNumber, cellNum: cellNum, dob: dob, regCountry: regCountry, idType: idType)
                    
                }, label: {
                    Text("Sign Up")
                        .font(.custom("Avenir", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }).buttonStyle(purpleButtonLong())
                    .disabled((lastName != "" && firstName != "" && email != "") ? false : true)
                    .opacity((lastName != "" && firstName != "" && email != "") ? 1 : 0.6)
                    .alert(isPresented: $viewModel.isError, content: {
                        Alert(title: Text("Registration Error"), message: Text(viewModel.errorMsg))
                    }).sheet(isPresented: $showOTPSheetView){}
            }
        }
        .background(bgWhite())
        .accentColor(purple)
        .keyboardAdaptive()
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
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
            self.keyboardHeight = 0
        }
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

struct KeyboardAdaptive: ViewModifier {
    @State private var bottomPadding: CGFloat = 0
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.bottomPadding)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    let keyboardTop = geometry.frame(in: .global).height - keyboardHeight
                    let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
                    self.bottomPadding = max(0, focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom)
                }
                .animation(.easeOut(duration: 0.16))
        }
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}

extension UIResponder {
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }
    
    private static weak var _currentFirstResponder: UIResponder?
    
    @objc private func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }
    
    var globalFrame: CGRect? {
        guard let view = self as? UIView else { return nil }
        return view.superview?.convert(view.frame, to: nil)
    }
}
