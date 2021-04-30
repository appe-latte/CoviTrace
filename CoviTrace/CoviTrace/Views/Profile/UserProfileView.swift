//
//  UserProfileView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 29/04/2021.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView()
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
