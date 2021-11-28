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
    @State private var testVerified = "pending"
    @State private var resultUploadDate = Date() // Logs the date that the results are uploaded onto the system
    @State private var specimenNum = ""
    @State private var pcrImageUrl = ""
    @State private var testResult = ""
    let selectResult = ["Pick Result", "NEGATIVE", "POSITIVE"]
    //    @State private var presentImporter = false // presents File importer
    
    // MARK: Image Picker
//    @State var selectedUIImage: UIImage?
//    @State var image: Image?
//    @State var showImagePicker = false
    
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
    
//    func loadImage(){
//        guard let selectedImage = selectedUIImage else {return}
//        image = Image(uiImage: selectedImage)
//    }
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var authModel = AuthViewModel()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter
    }
    
    var body: some View {
        let green = Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255)
        
        ZStack{
            Background()
            VStack{
                
                Text("Add PCR / Antigen Test Results")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                
                // MARK: Test Reference Number TextField
                SimpleTextField(text: $testRefNum, placeholder: Text("Enter Test Reference number"))
                    .foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Lab Ref Number TextField
                SimpleTextField(text: $labRefNum, placeholder: Text("Enter Lab Reference Number"))
                //                    .padding(5)
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
                    Text("Choose Result:")
                        .padding(.leading)
                        .foregroundColor(Color(.white)).font(.system(size: 14))
                    
                    Spacer()
                    
                    Picker("Result", selection: $testResult) {
                        ForEach(selectResult, id: \.self) {
                            Text($0)
                        }
                    }
                }.padding(.trailing, 50)
                    .foregroundColor(Color(.white))
                    .frame(width: UIScreen.main.bounds.size.width - 40, height: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                
                // MARK: Upload Test Certificate
                //                Button(action: {
                //                    presentImporter = true
                //                }, label: {
                //                    HStack {
                //                        Text("Upload Test Certificate")
                //                            .font(.custom("Avenir", size: 16))
                //                            .fontWeight(.bold)
                //                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                //                            .padding(.trailing, 10)
                //                    }
                //
                //                }).frame(width: UIScreen.main.bounds.size.width - 40, height: 50)
                //                    .background(Color.white)
                //                    .cornerRadius(10)
                //                    .padding(.top, 2)
                //                    .fileImporter(isPresented: $presentImporter, allowedContentTypes: [.pdf]) { result in
                //                        switch result {
                //                        case .success(let url):
                //                            print(url)
                //                            //use `url.startAccessingSecurityScopedResource()` if you are going to read the data
                //                        case .failure(let error):
                //                            print(error)
                //                        }
                //                    }
                
                Button(action: {
//                    showImagePicker.toggle()
                    self.showActionSheet = true
                }, label: {
                    HStack {
                        Text("Upload PCR Results Image")
                            .font(.custom("Avenir", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                            .padding(.trailing, 10)
                    }
                    
                }).frame(width: UIScreen.main.bounds.size.width - 40, height: 50)
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
//                    .sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
//                        ImagePicker(image: $selectedUIImage)
//                    })
                
                // MARK: "Log Results" Button
                Button(action: {
                    //                    upload_data()
                    
                    if let thisImage = self.upload_image {
                        uploadPcrImage(image: thisImage)
                        
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
                    } else {
                        showToastAlert.toggle()
                    }
                    
                    
//                    let date = dateFormatter.string(from: testDate)
//                    let pcrDictionary = [
//                        "userId": authModel.userSession!.uid,
//                        "test_ref_num": self.testRefNum,
//                        "lab_ref_num": self.labRefNum,
//                        "test_provider": self.testProvider,
//                        "date": date,
//                        "test_result": self.testResult,
//                        "test_verified": self.testVerified,
//                        "pcr_upload_date": self.resultUploadDate,
//                        "specimen_num": self.specimenNum,
//                        "pcrImageUrl": self.pcrImageUrl
//                    ] as [String : Any]
//
//                    let filename = NSUUID().uuidString
//                    let docRef = Firestore.firestore().document("pcr_results/\(filename)")
//
//                    docRef.setData(pcrDictionary){ (error) in
//                        if let error = error {
//                            print("Error: \(error)")
//                        } else {
//                            print("Form uploaded successfully")
//                        }
//                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Text("Submit")
                            .font(.custom("Avenir", size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                }).frame(width: UIScreen.main.bounds.size.width - 40, height: 50)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(10)
                    .padding(.top, 2)
                    .toast(isPresenting: $showToastAlert){
                        AlertToast(displayMode: .alert, type: .complete(green), title: Optional(errTitle), subTitle: Optional(errMessage))
                    }
                
                Spacer()
            }.padding(.top, 15)
            
        }.navigationBarHidden(false)
    }
    
    // MARK: Upload to "Results" DB
//    func upload_data(){
//        let db = Firestore.firestore()
//        let date = dateFormatter.string(from: testDate)
//        db.collection("results").document().setData(["userId": authModel.userSession!.uid, "test_ref_num": testRefNum, "lab_ref_num": labRefNum, "test_provider": testProvider, "date": date, "test_result": testResult, "test_verified": testVerified, "result_upload_date": resultUploadDate, "specimen_num": specimenNum])
//    }
    
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
                }
            }
        } else {
            print("Image couldn't be unwrapped")
        }
    }
}
