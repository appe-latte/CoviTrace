//
//  TermsView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/06/2021.
//

import SwiftUI
import WebKit

struct TermsView: View {
    @ObservedObject var webViewStateModel : WebViewStateModel = WebViewStateModel()
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: .constant(webViewStateModel.loading)) {
                WebView(url: URL.init(string: "https://www.iubenda.com/terms-and-conditions/52172420")!, webViewStateModel: self.webViewStateModel)
            }
        }.navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(Text("Privacy Policy"))
    }
}
