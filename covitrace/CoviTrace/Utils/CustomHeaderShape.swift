//
//  CurvedSidedRectangle.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 12/12/2021.
//

import SwiftUI

struct CustomHeaderShape: Shape {
    var offset: CGFloat = 0.75
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.maxY), control: CGPoint(x: rect.midX, y: rect.maxY -
                                                                            100))
        path.closeSubpath()
        
        return path
    }
}
