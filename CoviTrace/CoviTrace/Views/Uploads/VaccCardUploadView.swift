//
//  VaccCardUploadView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/11/2021.
//

import SwiftUI
import Firebase
import AlertToast
import FirebaseFirestore

struct VaccCardUploadView: View {
    @ObservedObject private var viewModel = ResultsViewModel()
    @ObservedObject private var authModel = AuthViewModel()
    @ObservedObject private var boosterModel = BoosterShotViewModel()
    @ObservedObject private var vaccModel = VaccinationViewModel()
    
    // MARK: Image Picker Properties
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @State private var sourceType:UIImagePickerController.SourceType = .camera
    @State private var image : UIImage?
    @State var upload_image : UIImage?
    
    // MARK: Alert
    @State private var showToastAlert : Bool = false
    @State private var errTitle = ""
    @State private var errMessage = ""
    
    var body: some View {
        let green = Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)
        let purple = Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
        
        ZStack {
            Background()
            VStack(spacing: 10) {
                VStack{
                    Text("Upload Vaccination Card")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .padding(.top, 15)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: Image frame
                    HStack{
                        if upload_image != nil {
                            Image(uiImage: upload_image!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.size.width - 40, height: 500)
                                .cornerRadius(10)
                        } else {
                            HStack {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.white)
                                    .frame(width:15, height:15)
                                Text("add Vaccination Card image")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.white)
                            }.frame(width: UIScreen.main.bounds.size.width - 40, height: 500)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                        }
                    }.padding()
                    
                    // MARK: Image Picker button
                    Button(action: {
                        self.showActionSheet = true
                    }) {
                        HStack {
                            Image(systemName: "camera")
                                .imageScale(.medium)
                                .scaledToFill()
                                .foregroundColor(green)
                            
                            Text(" / ")
                                .font(.system(size: 12))
                                .foregroundColor(green)
                            
                            Image(systemName: "photo")
                                .imageScale(.medium)
                                .scaledToFill()
                                .foregroundColor(green)
                        }
                    }.frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .actionSheet(isPresented: $showActionSheet){
                            ActionSheet(title: Text("Add Vaccincation Card"), message: nil, buttons: [
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
                            uploadVcardImage(image: thisImage)
                        } else {
                            showToastAlert.toggle()
                        }
                    }){
                        Text("Upload Card")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }.frame(width: UIScreen.main.bounds.size.width - 40, height: 50)
                        .background(green)
                        .cornerRadius(10)
                }
                
                Spacer()
                
            }.toast(isPresenting: $showToastAlert){
                AlertToast(displayMode: .alert, type: .complete(green), title: Optional(errTitle), subTitle: Optional(errMessage))
            }
        }
    }
    
    func uploadVcardImage(image:UIImage){
        if let imageData = image.jpegData(compressionQuality: 0.6){
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference(withPath: "/vaccination_cards/\(filename)")
            
            storageRef.putData(imageData, metadata: nil) {
                (_, err) in
                if let err = err {
                    self.errTitle = "Alert!"
                    self.errMessage = "\(err.localizedDescription)"
                    self.showToastAlert = true
                } else {
                    self.errTitle = "Success!"
                    self.errMessage = "Image upload complete"
                    self.showToastAlert = true
                }
            }
        } else {
            print("coldn't unwrap/case image to data")
        }
    }
}
