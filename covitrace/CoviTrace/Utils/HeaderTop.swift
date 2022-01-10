//
//  CustomBgShape.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 17/12/2021.
//

import SwiftUI

struct HeaderTop: View {
    var body: some View {
        GeometryReader { geo in
            Rectangle()
                .fill(Color(red: 83 / 255, green: 82 / 255, blue: 116 / 255))
                .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                .frame(width: geo.size.width, height: 225)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

// MARK: Corner radius for "HeaderTop"
struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
