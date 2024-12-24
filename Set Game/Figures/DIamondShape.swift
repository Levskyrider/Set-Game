//
//  DIamondShape.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 19.12.2024.
//

import SwiftUI

struct DiamondShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    let top = CGPoint(x: rect.midX, y: rect.minY)
    let right = CGPoint(x: rect.maxX, y: rect.midY)
    let bottom = CGPoint(x: rect.midX, y: rect.maxY)
    let left = CGPoint(x: rect.minX, y: rect.midY)
    
    path.move(to: top)
    path.addLine(to: right)
    path.addLine(to: bottom)
    path.addLine(to: left)
    path.closeSubpath()
    
    return path
  }
}

struct DIamondShapeTest: View {
  var body: some View {
    DiamondShape()
  }
}

#Preview {
  DIamondShapeTest()
}
