//
//  UpdateProfileImageView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 09/12/2021.
//

import SwiftUI
import Firebase
import AlertToast
import FirebaseFirestore

struct UpdateProfileImageView: View {
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var boosterModel = BoosterShotViewModel()
    @ObservedObject private var vaccModel = FirstDoseVaccViewModel()
    
    // MARK: Image Picker Properties
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @State private var sourceType : UIImagePickerController.SourceType = .camera
    @State private var image : UIImage?
    @State private var upload_image : UIImage?
    
    // MARK: Alert
    @State private var showToastAlert : Bool = false
    @State private var errTitle = ""
    @State private var errMessage = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 10) {
                HStack {
                    Text("Update Profile Image")
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
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: Image frame
                    Button(action: {
                        self.showActionSheet = true
                    }, label: {
                        VStack {
                            if upload_image != nil {
                                Image(uiImage: upload_image!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 300)
                                    .cornerRadius(10)
                                    .padding(.vertical, 5)
                            } else {
                                VStack {
                                    Text("+ tap to add new image")
                                        .font(.system(size: 12))
                                        .foregroundColor(purple)
                                }
                                .frame(width: UIScreen.main.bounds.size.width - 40, height: 300)
                                .background(purple.opacity(0.1))                                                                    .cornerRadius(10)
                                .padding(.vertical, 5)
                            }
                        }
                    }).actionSheet(isPresented: $showActionSheet){
                        ActionSheet(title: Text("Select profile image"), message: nil, buttons: [
                            
                            // MARK: take image using camera
                            .default(Text("Camera"), action: {
                                self.showImagePicker = true
                                self.sourceType = .camera
                            }),
                            
                            // MARK: pick image from Photo Library
                            .default(Text("Photo Library"), action: {
                                self.showImagePicker = true
                                self.sourceType = .photoLibrary
                            }),
                            
                            // MARK: "Cancel" button
                            .cancel()
                        ])
                    }.sheet(isPresented: $showImagePicker){
                        ImageUploader(image: self.$upload_image, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
                    }
                    
                    // MARK: Upload image to Firebase
                    Button(action: {
                        if let thisImage = self.upload_image {
                            uploadProfileImage(image: thisImage)
                        } else {
                            showToastAlert.toggle()
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Submit")
                            .font(.custom("Avenir", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }.buttonStyle(purpleButton())
                        .padding(.top, 2)
                }
                
                Spacer()
            }.toast(isPresenting: $showToastAlert){
                AlertToast(displayMode: .alert, type: .complete(green), title: Optional(errTitle), subTitle: Optional(errMessage))
            }
        }.background(bgWhite())
            .accentColor(purple)
    }
    
    func uploadProfileImage(image:UIImage){
        if let imageData = image.jpegData(compressionQuality: 0.6){
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference(withPath: "/profile_images/\(filename)")
            
            storageRef.putData(imageData, metadata: nil) {
                (_, err) in
                if let err = err {
                    self.errTitle = "Alert!"
                    self.errMessage = "\(err.localizedDescription)"
                    self.showToastAlert = true
                } else {
                    self.errTitle = "Success!"
                    self.errMessage = "Image uploaded"
                    self.showToastAlert = true
                    
                    storageRef.downloadURL { url, _ in
                        guard let profileImageViewUrl = url?.absoluteString else { return }
                        saveProfileImageViewURL(urlStr: profileImageViewUrl)
                    }
                }
            }
        } else {
            print("Image couldn't be unwrapped")
        }
    }
    
    func saveProfileImageViewURL(urlStr : String ){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["profileImageUrl": urlStr], merge: true)
    }
}
