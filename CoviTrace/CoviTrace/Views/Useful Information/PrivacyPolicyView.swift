//
//  PrivacyPolicyView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 12/02/2021.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ZStack
        {
            Background()
            
            VStack(alignment:.center){
                VStack{
                    //
                }.foregroundColor(.white)
                .lineLimit(nil)
                .font(.footnote)
                .padding(10)
                Spacer()
            }.padding(5)
            .frame(minHeight: 0, maxHeight: 800 )
        }.navigationBarTitle("Privacy Policy").navigationBarHidden(false)
    }
    
    struct PrivacyPolicyView_Previews: PreviewProvider {
        static var previews: some View {
            PrivacyPolicyView()
        }
    }
}
