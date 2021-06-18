//
//  FeedbackView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 14/06/2021.
//

import SwiftUI
import Combine

struct FeedbackView: View {
    @State private var fullName : String = ""
    @State private var email : String = ""
    @State private var feedback : String = ""
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                Form {
                    Section {
                        TextField("Full Name", text: self.$fullName)
                        TextField("Email", text: self.$email)
                    }
                    
                    Section {
                        TextArea("Leave Feedback", text: self.$feedback).frame(height: 250)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                    }
                }
                Spacer()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Submit")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.white))
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(10)
                        .padding()
                })
            }
            
            Spacer()
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}

