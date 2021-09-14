//
//  PrivacyView.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 11/06/2021.
//

import SwiftUI
import WebKit

struct PrivacyView: View {
    @ObservedObject var webViewStateModel : WebViewStateModel = WebViewStateModel()
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: .constant(webViewStateModel.loading)) {
                WebView(url: URL.init(string: "https://www.iubenda.com/privacy-policy/52172420")!, webViewStateModel: self.webViewStateModel)
            }
        }.navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(Text("Privacy Policy"))
    }
}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 :0)
                
                VStack {
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .foregroundColor(Color.white)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}

class WebViewStateModel: ObservableObject {
    @Published var pageTitle : String = "Web View"
    @Published var loading : Bool = false
    @Published var canGoBack : Bool = false
    @Published var goBack : Bool = false
}

struct WebView: View {
    enum NavigationAction {
        case decidePolicy(WKNavigationAction, (WKNavigationActionPolicy) -> Void)
        case didRecieveAuthChallenge(URLAuthenticationChallenge, (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
        case didStartProvisionalNavigation(WKNavigation)
        case didReceiveServerRedirectForProvisionalNavigation(WKNavigation)
        case didCommit(WKNavigation)
        case didFinish(WKNavigation)
        case didFailProvisionalNavigation(WKNavigation,Error)
        case didFail(WKNavigation,Error)
    }
    @ObservedObject var webViewStateModel: WebViewStateModel
    private var actionDelegate: ((_ navigationAction: WebView.NavigationAction) -> Void)?
    
    let urlRequest: URLRequest
    
    var body: some View {
        WebViewWrapper(webViewStateModel: webViewStateModel,
                       action: actionDelegate,
                       request: urlRequest)
    }
    
    init(urlRequest: URLRequest, webViewStateModel: WebViewStateModel, onNavigationAction: ((_ navigationAction: WebView.NavigationAction) -> Void)?) {
        self.urlRequest = urlRequest
        self.webViewStateModel = webViewStateModel
        self.actionDelegate = onNavigationAction
    }
    
    init(url: URL, webViewStateModel: WebViewStateModel, onNavigationAction: ((_ navigationAction: WebView.NavigationAction) -> Void)? = nil) {
        self.init(urlRequest: URLRequest(url: url),
                  webViewStateModel: webViewStateModel,
                  onNavigationAction: onNavigationAction)
    }
}

final class WebViewWrapper : UIViewRepresentable {
    @ObservedObject var webViewStateModel: WebViewStateModel
    let action: ((_ navigationAction: WebView.NavigationAction) -> Void)?
    
    let request: URLRequest
    
    init(webViewStateModel: WebViewStateModel,
         action: ((_ navigationAction: WebView.NavigationAction) -> Void)?,
         request: URLRequest) {
        self.action = action
        self.request = request
        self.webViewStateModel = webViewStateModel
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.navigationDelegate = context.coordinator
        view.load(request)
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.canGoBack, webViewStateModel.goBack {
            uiView.goBack()
            webViewStateModel.goBack = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(action: action, webViewStateModel: webViewStateModel)
    }
    
    final class Coordinator: NSObject {
        @ObservedObject var webViewStateModel : WebViewStateModel
        
        let action: ((_ navigationAction: WebView.NavigationAction) -> Void)?
        
        init(action: ((_ navigationAction: WebView.NavigationAction) -> Void)?,
             webViewStateModel: WebViewStateModel) {
            self.action = action
            self.webViewStateModel = webViewStateModel
        }
    }
}

extension WebViewWrapper.Coordinator: WKNavigationDelegate {
    private func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigation, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if action == nil {
            decisionHandler(.allow)
        } else {
            //            action?(.decidePolicy(navigationAction, decisionHandler))
            
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webViewStateModel.loading = true
        action?(.didStartProvisionalNavigation(navigation))
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        action?(.didReceiveServerRedirectForProvisionalNavigation(navigation))
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        webViewStateModel.loading = false
        webViewStateModel.canGoBack = webView.canGoBack
        action?(.didFailProvisionalNavigation(navigation, error))
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        action?(.didCommit(navigation))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webViewStateModel.loading = false
        webViewStateModel.canGoBack = webView.canGoBack
        if let title = webView.title {
            webViewStateModel.pageTitle = title
        }
        action?(.didFinish(navigation))
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if action == nil {
            completionHandler(.performDefaultHandling, nil)
        } else {
            action?(.didRecieveAuthChallenge(challenge, completionHandler))
        }
    }
}
