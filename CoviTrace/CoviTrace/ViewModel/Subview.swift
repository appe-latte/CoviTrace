//
//  Subview.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 06/03/2021.
//

import SwiftUI

struct Subview: View {
    var imageString: String
    var body: some View {
        Image(imageString)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
    }
}

struct Subview_Previews: PreviewProvider {
    static var previews: some View {
        Subview(imageString: "unwell")
    }
}
