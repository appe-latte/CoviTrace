//
//  VaccCardUploadView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/11/2021.
//

import SwiftUI
import Firebase
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
    @State var upload_image:UIImage?
    
    var body: some View {
        ZStack {
            Background()
            //            VStack (spacing: 10) {
            //                // MARK: Image Container
            //                VStack {
            //
            //
            //                }.frame(minWidth: 0, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: UIScreen.main.bounds.size.height - 40)
            //            }
            
            VStack {
                HStack{
                    //Uploading image
                    if upload_image != nil {
                        Image(uiImage: upload_image!)
                            .resizable()
                            .scaledToFit()
                            .frame(width:120, height:120)
                    } else {
                        Image(systemName: "timelapse")
                            .resizable()
                            .scaledToFit()
                            .frame(width:300, height:300)
                    }
                    //                    Spacer()
                    //                    if download_image != nil {
                    //                        Image(uiImage: download_image!)
                    //                        .resizable()
                    //                        .scaledToFit()
                    //                            .frame(width:120, height:120)
                    //                    } else {
                    //                        Image(systemName: "timelapse")
                    //                        .resizable()
                    //                        .scaledToFit()
                    //                            .frame(width:120, height:120)
                    //                    }
                }.padding()
                //Button for image picker
                Button(action: {
                    self.showActionSheet = true
                }) {
                    Text("Show Image Picker")
                }.actionSheet(isPresented: $showActionSheet){
                    ActionSheet(title: Text("Add a picture to your post"), message: nil, buttons: [
                        //Button1
                        
                        .default(Text("Camera"), action: {
                            self.showImagePicker = true
                            self.sourceType = .camera
                        }),
                        //Button2
                        .default(Text("Photo Library"), action: {
                            self.showImagePicker = true
                            self.sourceType = .photoLibrary
                        }),
                        
                        //Button3
                        .cancel()
                        
                    ])
                }.sheet(isPresented: $showImagePicker){
                    VaccineCardImagePicker(image: self.$upload_image, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
                    
                }
                
                //Button for upload
                Button(action: {
                    if let thisImage = self.upload_image {
                        uploadImage(image: thisImage)
                    } else {
                        print("")
                    }
                    
                }){
                    Text("Upload Image")
                }
            }
            
        }
    }
}

func uploadImage(image:UIImage){
    if let imageData = image.jpegData(compressionQuality: 1){
        let storage = Storage.storage()
        storage.reference().child("vaccination_card").putData(imageData, metadata: nil){
            (_, err) in
            if let err = err {
                print("an error has occurred - \(err.localizedDescription)")
            } else {
                print("image uploaded successfully")
            }
        }
    } else {
        print("coldn't unwrap/case image to data")
    }
}
