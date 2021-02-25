//
//  ResultsTopView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 12/02/2021.
//

import SwiftUI

struct ResultsTopView: View {
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .fill(Color(red: 246/255, green: 245/255, blue: 243/255))
            VStack{
                Rectangle()
                    .fill(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                    .frame(height: 450, alignment: .top)
                    .edgesIgnoringSafeArea(.all)
                Spacer()
            }
        }
    }
    
    struct ResultsTopView_Previews: PreviewProvider {
        static var previews: some View {
            ResultsTopView()
        }
    }
}
