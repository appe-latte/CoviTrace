//
//  AddResultsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/02/2021.
//

import SwiftUI
import Firebase
import AlertToast
import FirebaseFirestore

struct AddResultsView: View {
    @State private var isPresented = true
    @State private var testRefNum = ""
    @State private var labRefNum = ""
    @State private var testDate = Date()
    @State private var testProvider = ""
    @State private var userId = ""
    @State private var testVerified = "Not Verified"
    @State private var resultUploadDate = Date() // Logs the date that the results are uploaded onto the system
    @State private var specimenNum = ""
    @State private var pcrImageUrl = ""
    @State private var testResult = ""
    let selectResult = ["Pick Result", "NEGATIVE", "POSITIVE"]
    
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
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var authModel = AuthViewModel()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter
    }
    
    var body: some View {
        let green = Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)
        
        ZStack {
            VStack {
                HStack {
                    Text("Add PCR Results")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image("close")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }).padding(5)
                        .clipShape(Circle())
                }
                .padding(.top, 15)
                .padding(.horizontal, 15)
                
                // MARK: Test Reference Number TextField
                SimpleTextField(text: $testRefNum, placeholder: Text("Enter Test Reference number"))
                    .foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Lab Ref Number TextField
                SimpleTextField(text: $labRefNum, placeholder: Text("Enter Lab Reference Number"))
                    .foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Specimen Number
                SimpleTextField(text: $specimenNum, placeholder: Text("Enter Specimen Number"))
                    .foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Test Location TextField
                SimpleTextField(text: $testProvider, placeholder: Text("Enter Test Provider"))
                    .foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Test Date Picker
                DatePicker(selection: $testDate, in: ...Date(), displayedComponents: .date) {
                    Text("Test Date:")
                        .padding(.leading)
                        .foregroundColor(Color(.white)).font(.system(size: 14))
                }.foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1)).font(.system(size: 14))
                    .cornerRadius(15)
                
                // MARK: Test Result Picker
               
                
                HStack {
                    Text("Test Result:")
                        .padding(.leading)
                        .font(.custom("Avenir", size: 14).bold())
                        .foregroundColor(Color(.white))
                    
                    Spacer()
                    
                    Picker("Result", selection: $testResult) {
                        ForEach(selectResult, id: \.self) {
                            Text($0)
                                .font(.custom("Avenir", size: 14))
                        }
                    }.frame(width: 110)
                }.padding(.trailing, 50)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                Button(action: {
                    self.showActionSheet = true
                }, label: {
                    HStack(spacing: 2) {
                        Image("camera")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("upload image")
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                    }
                }).frame(width: 150, height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.top, 2)
                    .actionSheet(isPresented: $showActionSheet){
                        ActionSheet(title: Text("Upload PCR Results"), message: nil, buttons: [
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
                
                // MARK: "Log Results" Button
                Button(action: {
                    if let thisImage = self.upload_image {
                        uploadPcrImage(image: thisImage)
                    } else {
                        showToastAlert.toggle()
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Text("Submit")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }).frame(width: 150, height: 50)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(10)
                    .padding(.top, 2)
                    .toast(isPresenting: $showToastAlert){
                        AlertToast(displayMode: .alert, type: .complete(green), title: Optional(errTitle), subTitle: Optional(errMessage))
                    }
                
                Spacer()
            }.padding(.top, 15)
        }.background(bgPurple())
            .navigationBarHidden(false)
            .accentColor(Color.white)
    }
    
    func uploadPcrImage(image:UIImage){
        if let imageData = image.jpegData(compressionQuality: 0.6){
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference(withPath: "/pcr_certificates/\(filename)")
            
            storageRef.putData(imageData, metadata: nil) {
                (_, err) in
                if let err = err {
                    self.errTitle = "Alert!"
                    self.errMessage = "\(err.localizedDescription)"
                    self.showToastAlert = true
                } else {
                    self.errTitle = "Success!"
                    self.errMessage = "PCR information uploaded!"
                    self.showToastAlert = true
                    storageRef.downloadURL { url, _ in
                        guard let imageUrl = url?.absoluteString else { return }
                        self.pcrImageUrl = imageUrl
                        let date = dateFormatter.string(from: testDate)
                        let pcrDictionary = [
                            "userId": authModel.userSession!.uid,
                            "test_ref_num": self.testRefNum,
                            "lab_ref_num": self.labRefNum,
                            "test_provider": self.testProvider,
                            "date": date,
                            "test_result": self.testResult,
                            "test_verified": self.testVerified,
                            "pcr_upload_date": self.resultUploadDate,
                            "specimen_num": self.specimenNum,
                            "pcrImageUrl": self.pcrImageUrl
                        ] as [String : Any]
                        
                        let filename = NSUUID().uuidString
                        let docRef = Firestore.firestore().document("pcr_results/\(filename)")
                        
                        docRef.setData(pcrDictionary){ (error) in
                            if let error = error {
                                print("Error: \(error)")
                            } else {
                                print("Form uploaded successfully")
                            }
                        }
                    }
                }
            }
        } else {
            print("Image couldn't be unwrapped")
        }
    }
}
