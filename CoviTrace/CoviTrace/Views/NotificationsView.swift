//
//  NotificationsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 14/06/2021.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        ZStack {
            Background()
            VStack {
                Text("Notifications Here ...")
                    .bold()
                    .foregroundColor(.white)
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
