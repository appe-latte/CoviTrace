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
    @State private var testType = ""
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
    let selectResult = ["Select Result", "Negative", "Positive"]
    
    let selectTestType = ["Select Test", "PCR", "Rapid"]
    
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
        ZStack {
            VStack {
                HStack {
                    Text("Add Test Results")
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
                
                VStack(spacing: 10) {
                    
                    // MARK: Test Type Picker
                    HStack {
                        Text("Test Type:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(purple)
                        
                        Spacer()
                        
                        Picker("Type", selection: $testType) {
                            ForEach(selectTestType, id: \.self) {
                                Text($0)
                                    .font(.custom("Avenir", size: 14))
                            }
                        }.frame(width: 110)
                    }
                    .foregroundColor(purple)
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    
                    // MARK: Test Result Picker
                    HStack {
                        Text("Test Result:")
                            .padding(.leading)
                            .font(.custom("Avenir", size: 14).bold())
                            .foregroundColor(purple)
                        
                        Spacer()
                        
                        Picker("Result", selection: $testResult) {
                            ForEach(selectResult, id: \.self) {
                                Text($0)
                                    .font(.custom("Avenir", size: 14))
                            }
                        }.frame(width: 110)
                    }
                    .foregroundColor(purple)
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    
                    // MARK: Test Date Picker
                    DatePicker(selection: $testDate, in: ...Date(), displayedComponents: .date) {
                        Text("Test Date:")
                            .padding(.leading)
                            .foregroundColor(purple).font(.system(size: 14))
                    }.foregroundColor(purple)
                        .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    
                    // MARK: Test Reference Number TextField
                    SimpleTextField(text: $testRefNum, placeholder: Text("Enter test ref. number"))
                        .foregroundColor(purple)
                        .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    
                    // MARK: Lab Ref Number TextField
                    SimpleTextField(text: $labRefNum, placeholder: Text("Enter lab ref. number"))
                        .foregroundColor(purple)
                        .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    
                    // MARK: Specimen Number
                    SimpleTextField(text: $specimenNum, placeholder: Text("Enter specimen number"))
                        .foregroundColor(purple)
                        .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    
                    // MARK: Test Location TextField
                    SimpleTextField(text: $testProvider, placeholder: Text("Enter test provider"))
                        .foregroundColor(purple)
                        .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    
                    // MARK: Image frame
                    Button(action: {
                        self.showActionSheet = true
                    }, label: {
                        VStack {
                            if upload_image != nil {
                                Image(uiImage: upload_image!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 100)
                                    .cornerRadius(10)
                                    .padding(.vertical, 5)
                            } else {
                                VStack {
                                    Text("+ tap to add pcr image")
                                        .font(.system(size: 10))
                                        .foregroundColor(purple)
                                }
                                .frame(width: 120, height: 100)
                                .background(purple.opacity(0.1))                                                                    .cornerRadius(10)
                                .padding(.vertical, 5)
                            }
                        }
                    }).actionSheet(isPresented: $showActionSheet){
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
                    }).buttonStyle(purpleButtonLong())
                        .padding(.top, 2)
                        .disabled((testRefNum != "" && testProvider != "") ? false : true)
                        .opacity((testRefNum != "" && testProvider != "") ? 1 : 0.6)
                        .toast(isPresenting: $showToastAlert){
                            AlertToast(displayMode: .alert, type: .complete(green), title: Optional(errTitle), subTitle: Optional(errMessage))
                        }
                    
                }.padding(.top, 10)
                
                Spacer()
            }
        }.background(bgWhite())
            .accentColor(green)
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
                            "test_ref_num" : self.testRefNum,
                            "lab_ref_num" : self.labRefNum,
                            "test_provider" : self.testProvider,
                            "date" : date,
                            "test_result" : self.testResult,
                            "test_verified" : self.testVerified,
                            "pcr_upload_date"  : self.resultUploadDate,
                            "specimen_num" : self.specimenNum,
                            "pcrImageUrl" : self.pcrImageUrl,
                            "test_type" : self.testType
                        ] as [String : Any]
                        
                        let filename = NSUUID().uuidString
                        let docRef = Firestore.firestore().document("pcr_results/\(filename)")
                        
                        docRef.setData(pcrDictionary){ (error) in
                            if let error = error {
                                print("Error: \(error)")
                            } else {
                                print("Test results uploaded successfully")
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
