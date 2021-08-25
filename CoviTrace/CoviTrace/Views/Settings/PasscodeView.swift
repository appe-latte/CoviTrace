//
//  PasscodeView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 19/08/2021.
//

import SwiftUI

struct PasscodeView: View {
    var body: some View {
        ZStack {
            Background()
            VStack{
                Text("Set Passcode")
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
    }
}

struct PasscodeChangeView_Previews: PreviewProvider {
    static var previews: some View {
        PasscodeView()
    }
}
