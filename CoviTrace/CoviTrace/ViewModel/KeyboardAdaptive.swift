//
//  KeyboardAdaptive.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 22/02/2021.
//

import SwiftUI
import Combine

//extension Publishers {
//    // 1.
//    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
//        // 2.
//        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
//            .map { $0.keyboardHeight }
//        
//        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
//            .map { _ in CGFloat(0) }
//        
//        // 3.
//        return MergeMany(willShow, willHide)
//            .eraseToAnyPublisher()
//    }
//}
//
//extension Notification {
//    var keyboardHeight: CGFloat {
//        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
//    }
//}
//
//struct KeyboardAdaptive: ViewModifier {
//    @State private var keyboardHeight: CGFloat = 0
//
//    func body(content: Content) -> some View {
//        content
//            .padding(.bottom, keyboardHeight)
//            .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
//    }
//}
//
//extension View {
//    func keyboardAdaptive() -> some View {
//        ModifiedContent(content: self, modifier: KeyboardAdaptive())
//    }
//}
