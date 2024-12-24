//
//  EllipseShape.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 23.12.2024.
//

import SwiftUI

struct EllipseShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.addEllipse(in: rect)
    return path
  }
}

#Preview {
  EllipseShape()
    .fill(Color.red)
}
