//
//  LandingView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI
import Combine

struct LandingView: View {
    
    var body: some View {
        
        NavigationView{
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    VStack{
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                        Text("CoviTrace")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
                
                VStack(alignment:.trailing) {
                    Spacer()
                    VStack {
                        //MARK: "Register" Button
                        NavigationLink(
                            destination: SignUpView()){
                                Text("Register")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40)
                            .padding()
                            .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .background(Color(.white))
                            .cornerRadius(10)
                        
                        // MARK: "Login" Button
                        NavigationLink(
                            destination: LoginView()){
                                Text("Login")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                            }
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: UIScreen.main.bounds.size.width - 40)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                            .cornerRadius(10)
                    }
                }.padding()
            }.navigationBarTitle("", displayMode: .inline)}
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
            .accentColor(Color.white)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
