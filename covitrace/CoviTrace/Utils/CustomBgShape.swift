//
//  CustomBgShape.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 17/12/2021.
//

import SwiftUI

struct CustomBgShape: Shape {
    var offset: CGFloat = 0.75
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY * offset))
        
        return path
    }
}

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
