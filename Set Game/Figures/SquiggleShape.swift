//
//  SquiggleShape.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 19.12.2024.
//

import SwiftUI

//MARK: - Squiggle
struct SquiggleShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    let width = rect.width
    let height = rect.height
    
    path.move(to: CGPoint(x: 0.15 * width, y: 0.15 * height))
    
    path.addCurve(
      to: CGPoint(x: 0.85 * width, y: 0.15 * height),
      control1: CGPoint(x: 0.6 * width, y: 0.2 * height),
      control2: CGPoint(x: 0.7 * width, y: 0.5 * height)
    )
    
    path.addCurve(
      to: CGPoint(x: 0.85 * width, y: 0.85 * height),
      control1: CGPoint(x: 0.85 * width, y: 0.3 * height),
      control2: CGPoint(x: 0.5 * width, y: 0.7 * height)
    )
    
    path.addCurve(
      to: CGPoint(x: 0.15 * width, y: 0.85 * height),
      control1: CGPoint(x: 0.4 * width, y: 0.8 * height),
      control2: CGPoint(x: 0.3 * width, y: 0.5 * height)
    )
    
    path.addCurve(
      to: CGPoint(x: 0.15 * width, y: 0.15 * height),
      control1: CGPoint(x: 0.15 * width, y: 0.7 * height),
      control2: CGPoint(x: 0.5 * width, y: 0.3 * height)
    )
    
    
    path.closeSubpath()
    
    
    return path
  }
}

struct SquiggleShapeTest: View {
  var body: some View {
    SquiggleShape()
      .stroke(.red, lineWidth: 5)
  }
}

#Preview {
  SquiggleShapeTest()
}
