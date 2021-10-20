//
//  AccountSuccessView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 20/10/2021.
//

import SwiftUI

struct AccountSuccessView: View {
    var body: some View {
        ZStack {
            Background()
            VStack(alignment: .center) {
                
                // MARK: View Heading
                Text("Welcome to Covitrace")
                    .font(.system(size: 40).bold())
                    .foregroundColor(Color(.white))
                    .padding(.top, 50)
                
                Text("Your account has been successfully created!")
                    .font(.system(size: 16))
                    .foregroundColor(Color(.white))
                    .padding(.top, 5)
                
                Spacer()
                    
                // MARK: Move to Content View
                
                Button(
                    action: {
                        
                    },
                    label: {
                        Text("WELCOME")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40, minHeight: 0, maxHeight: 50, alignment: .center).padding(.leading, 15)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(15)
            }
        }
    }
}

struct AccountSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSuccessView()
    }
}
