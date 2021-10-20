//
//  PhoneVerificationView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 23/09/2021.
//

import SwiftUI
import Firebase

struct PhoneVerificationView: View {
    @State var userCellNum = ""
    @State var otpCode = ""
    
    var body: some View {
        ZStack {
            Background()
            
            VStack (alignment: .center){
                
                // MARK: View Heading
                Text("Phone Verification")
                    .font(.system(size: 26).bold())
                    .foregroundColor(Color(.white))
                    .padding(.trailing, 150)
                
                // MARK: User Email Text
                CustomTextField(text: $userCellNum, placeholder: Text("enter cellphone number"), imageName: "")
                    .padding(5)
                    .foregroundColor(Color(.white))
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50).padding(.leading,10)
                    .background(Color(.white).opacity(0.1))
                    .cornerRadius(15)
                    .padding(.top, 20)
                
                Text("Please enter your cellphone number to receive a verification code for authentication purposes.")
                    .foregroundColor(.white)
                    .font(.system(size: 10))
                    .padding(.horizontal, 5)
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 30)
                
                Spacer()
                
                // MARK: "Verify" Button
                Button(action: {
                    
                }, label: {
                    Text("NEXT")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading, 15)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
                
            }.font(.subheadline)
                .padding(10)
        }
    }
}

struct PhoneVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneVerificationView()
    }
}
