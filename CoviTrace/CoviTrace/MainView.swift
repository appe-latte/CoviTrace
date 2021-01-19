//
//  MainView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 19/01/2021.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
        ZStack
        {
            // MARK: BACKGROUND COLOUR CODE:
            Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255)
                .ignoresSafeArea()
            
            VStack(alignment:.center){
                Spacer()
                Button(action: {
                    print("button 1")
                }) {
                    HStack {
                        Text("ENTER")
                            .fontWeight(.bold)
                        Image(systemName: "chevron.right")
                            .font(.title3)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(40)
            }
                Spacer()
                Button(action: {
                    print("button 2")
                }) {
                    HStack {
                        Text("ENTER")
                            .fontWeight(.bold)
                        Image(systemName: "chevron.right")
                            .font(.title3)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                    .cornerRadius(40)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
    
}
}
