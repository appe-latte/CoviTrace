//
//  ProfileImageRegistrationView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 01/10/2021.
//

import SwiftUI
import Firebase

struct ProfileImageRegistrationView: View {
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    @State var showImagePicker = false
    
    func loadImage(){
        guard let selectedImage = selectedUIImage else {return}
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Background()
                VStack(alignment: .center) {
                    VStack(alignment:.center){
                        Button(action: {showImagePicker.toggle()}, label: {
                            ZStack {
                                
                                if let image = image {
                                    image
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 250, height: 250)
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .renderingMode(.template)
                                        .scaledToFill()
                                        .frame(width: 250, height: 250)
                                        .foregroundColor(.white)
                                }
                            }
                        }).sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                            ImagePicker(image: $selectedUIImage)
                        })
                        Text("Add Profile Image")
                            .foregroundColor(.white)
                            .padding()
                        
                        Spacer()
                        
                        // MARK: Complete Registration Button
                        
                        Button(action: {
                            
                        }, label: {
                            Text("NEXT")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading, 15)
                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .cornerRadius(15)
                    }
                }
            }
        }.navigationTitle("Upload Profile Image")
            .navigationBarHidden(true)
    }
}

struct ProfileImageRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageRegistrationView()
    }
}
