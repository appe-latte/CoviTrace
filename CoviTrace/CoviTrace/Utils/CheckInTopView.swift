//
//  CheckInTopView.swift
//  CoviTrace
//
//  Created by Appè Latteon 11/02/2021.
//

import SwiftUI

struct CheckInTopView: View {
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .fill(Color(red: 246/255, green: 245/255, blue: 243/255))
            VStack{
            Rectangle()
                .fill(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                .frame(height: 300)
                .edgesIgnoringSafeArea(.all)
                Spacer()
            }
        }
    }
}
