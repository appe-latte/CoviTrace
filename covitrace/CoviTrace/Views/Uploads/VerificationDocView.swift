//
//  VerificationDocView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 12/12/2021.
//

import SwiftUI
import Firebase
import AlertToast
import FirebaseFirestore

struct VerificationDocView: View {
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    
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
                    Text("Profile Verification")
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
                    VStack(spacing: 5) {
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
                                        Text("+ tap to add ID image")
                                            .font(.system(size: 12))
                                            .foregroundColor(purple)
                                    }
                                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 300)
                                    .background(purple.opacity(0.1))                                                                    .cornerRadius(10)
                                    .padding(.vertical, 5)
                                }
                            }
                        }).actionSheet(isPresented: $showActionSheet){
                            ActionSheet(title: Text("Add proof of ID"), message: nil, buttons: [
                                
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
                        
                        HStack {
                            Text("NOTE: On completion of verification this image will be immediately deleted from our server.").lineLimit(nil)
                                .foregroundColor(purple)
                                .font(.custom("Avenir", size: 12).bold())
                        }.padding(.horizontal, 10)
                    }
                    
                    // MARK: Upload image to Firebase
                    Button(action: {
                        if let thisImage = self.upload_image {
                            uploadVerImage(image: thisImage)
                            
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
    
    func uploadVerImage(image:UIImage){
        if let imageData = image.jpegData(compressionQuality: 0.6){
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference(withPath: "/govt_id/\(filename)")
            
            storageRef.putData(imageData, metadata: nil) {
                (_, err) in
                if let err = err {
                    self.errTitle = "Alert!"
                    self.errMessage = "\(err.localizedDescription)"
                    self.showToastAlert = true
                } else {
                    self.errTitle = "Success!"
                    self.errMessage = "ID sent for verification"
                    self.showToastAlert = true
                    
                    storageRef.downloadURL { url, _ in
                        guard let verImgUrl = url?.absoluteString else { return }
                        saveVerImgViewURL(urlStr: verImgUrl)
                    }
                }
            }
        } else {
            print("Image couldn't be unwrapped")
        }
    }
    
    func saveVerImgViewURL(urlStr : String ){
        let db = Firestore.firestore()
        db.collection("users").document(authModel.userSession!.uid).setData(["verImgUrl": urlStr], merge: true)
    }
    
}
