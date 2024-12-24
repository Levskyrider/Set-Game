//
//  StripedFigure.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 23.12.2024.
//

import SwiftUI

struct StripedShape<Figure: Shape>: View {
  var color: Color
  var shape: Figure
  
  init(color: Color, shape: Figure) {
    self.color = color
    self.shape = shape
  }
  
  var body: some View {
    ZStack {
      shape.stroke(color, lineWidth: 5)
      
      Canvas { context, size in
        let step: CGFloat = 10 // Distance between lines
        
        context.stroke(
          Path { path in
            for x in stride(from: -size.height, to: size.width, by: step) {
              path.move(to: CGPoint(x: x, y: 0))
              path.addLine(to: CGPoint(x: x + size.height, y: size.height))
            }
          },
          with: .color(color),
          lineWidth: 1
        )
      }
      .mask(shape)
    }
  }
  
}
