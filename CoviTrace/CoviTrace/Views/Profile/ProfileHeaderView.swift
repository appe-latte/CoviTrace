//
//  ProfileHeaderView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 29/04/2021.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State var firstName = ""
    @State var lastName = ""
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        ZStack {
        VStack(alignment:.center){
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 300, height: 100)
                .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
            
            Text("Hello,")
                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                .font(.title3)
                .fontWeight(.semibold)
            Text(firstName)
                .fontWeight(.semibold)
                .foregroundColor(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                .font(.title2)
        }
        .padding(10)
    }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}
