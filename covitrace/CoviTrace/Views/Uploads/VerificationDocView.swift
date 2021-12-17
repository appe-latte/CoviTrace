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
        let green = Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
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
                    HStack{
                        if upload_image != nil {
                            Image(uiImage: upload_image!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.size.width - 40, height: 600)
                                .cornerRadius(10)
                        } else {
                            VStack {
                                HStack {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(purple)
                                        .frame(width:15, height:15)
                                    Text("add ID image for verification")
                                        .font(.system(size: 14))
                                        .foregroundColor(purple)
                                }.frame(width: UIScreen.main.bounds.size.width - 40, height: 300)
                                    .background(purple.opacity(0.1))
                                    .cornerRadius(10)
                                
                                HStack {
                                    Text("NOTE: On completion of verification this image will be immediately deleted from our server.").lineLimit(nil)
                                        .foregroundColor(purple)
                                        .font(.custom("Avenir", size: 12).bold())
                                }
                            }
                        }
                    }.padding(5)
                    
                    // MARK: Image Picker button
                    Button(action: {
                        self.showActionSheet = true
                    }) {
                        HStack(spacing: 2) {
                            Image("camera")
                                .resizable()
                                .frame(width: 25, height: 25)
                            Text("upload image")
                                .font(.custom("Avenir", size: 14).bold())
                                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                        }
                    }.buttonStyle(purpleBorderButton())
                        .padding(.top, 2)
                        .actionSheet(isPresented: $showActionSheet){
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
                    
                    // MARK: Upload image to Firebase
                    Button(action: {
                        if let thisImage = self.upload_image {
                            uploadVerImage(image: thisImage)
                        } else {
                            showToastAlert.toggle()
                        }
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
