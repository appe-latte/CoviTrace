//
//  LandingView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 08/02/2021.
//

import SwiftUI

struct LandingView: View {
    @ObservedObject var dataFetch = CovidFetchRequest()
    
    var body: some View {
        
        NavigationView{
            ZStack
            {
                // MARK: BACKGROUND COLOUR CODE:
                Background()
                
                VStack(alignment:.center){
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
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
                            Image(systemName: "chevron.right")
                                .font(.title3)
                        }
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250)
                        .padding()
                        .foregroundColor(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .background(Color(.white))
                        .cornerRadius(30)
                        
                        // MARK: "Login" Button
                        NavigationLink(
                            destination: LoginView()){
                            Text("Login")
                                .fontWeight(.semibold)
                                .font(.title3)
                            Image(systemName: "chevron.right")
                                .font(.title3)
                        }
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: 250)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 46 / 255, green: 153 / 255, blue: 168 / 255))
                        .cornerRadius(30)
                    }
                }.padding()
            }
        }.navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
