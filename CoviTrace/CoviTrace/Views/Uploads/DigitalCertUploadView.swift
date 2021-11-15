//
//  DigitalCertUploadView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 14/11/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct DigitalCertUploadView : View {
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
    
    @State private var presentImporter = false // presents File importer
    
    var body: some View {
        ZStack {
            Background()
            
                VStack(spacing: 10) {
                    VStack{
                        Text("Upload Digital Certificate")
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
                                Text("add Digital Certificate image.")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.white)
                            }.frame(width: UIScreen.main.bounds.size.width - 40, height: 500)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                        }
                    }.padding(5)
                    
                    // MARK: Image Picker button
                    Button(action: {
                        self.showActionSheet = true
                    }) {
                        HStack {
                            Image(systemName: "camera")
                                .imageScale(.medium)
                                .scaledToFill()
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            
                            Text(" / ")
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            
                            Image(systemName: "photo")
                                .imageScale(.medium)
                                .scaledToFill()
                                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        }
                    }.frame(width: UIScreen.main.bounds.size.width - 40, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        .actionSheet(isPresented: $showActionSheet){
                            ActionSheet(title: Text("Add Digital Certificate"), message: nil, buttons: [
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
                                
                                // MARK: .PDF image
                                .default(Text(".PDF"), action: {
                                    self.presentImporter = true
                                }),
                                
                                // MARK: "Cancel" button
                                .cancel()
                                
                            ])
                        }.sheet(isPresented: $showImagePicker){
                            VaccineCardImagePicker(image: self.$upload_image, showImagePicker: self.$showImagePicker, sourceType: self.sourceType)
                        }
                    
                    // MARK: Upload image to Firebase
                    Button(action: {
                        if let thisImage = self.upload_image {
                            uploadImage(image: thisImage)
                        } else {
                            print("")
                        }
                        
                    }){
                        Text("Upload Image")
                            .font(.system(size: 14))
                            .foregroundColor(Color.white)
                    }.frame(width: UIScreen.main.bounds.size.width - 40, height: 50)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                    
                    Spacer()
                }
            }.ignoresSafeArea()
        }
    }
}
