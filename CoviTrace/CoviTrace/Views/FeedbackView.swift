//
//  FeedbackView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 14/06/2021.
//

import SwiftUI

struct FeedbackView: View {
    var body: some View {
        ZStack {
            Background()
            VStack {
                Text("Feedback Form ...")
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}
