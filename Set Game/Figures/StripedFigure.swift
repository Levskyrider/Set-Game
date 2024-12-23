//
//  StripedFigure.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 23.12.2024.
//

import SwiftUI

struct StripedFigure: View {
  
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    StripedFigure()
}


struct StripedSquiggle: View {
  var color: Color
  
  init(color: Color) {
    self.color = color
  }
    var body: some View {
        ZStack {
            SquiggleShape()
                .stroke(color, lineWidth: 5) // Обводка
            
            Canvas { context, size in
                let step: CGFloat = 5 // Расстояние между линиями
                
                context.stroke(
                    Path { path in
                        for x in stride(from: 0, to: size.width + size.height, by: step) {
                            path.move(to: CGPoint(x: x, y: 0))
                            path.addLine(to: CGPoint(x: x - size.height, y: size.height))
                        }
                    },
                    with: .color(color.opacity(0.5)),
                    lineWidth: 1
                )
            }
            .mask(SquiggleShape()) // Маска для закорючки
        }
        //.frame(width: 400, height: 200) // Размер всей фигуры
    }
}

struct StripedEllipse: View {
  var color: Color
  
  init(color: Color) {
    self.color = color
  }
  
    var body: some View {
        ZStack {
          EllipseShape()
                .stroke(color, lineWidth: 5) // Обводка
            
            Canvas { context, size in
                let step: CGFloat = 5 // Расстояние между линиями
                
                context.stroke(
                    Path { path in
                        for x in stride(from: 0, to: size.width + size.height, by: step) {
                            path.move(to: CGPoint(x: x, y: 0))
                            path.addLine(to: CGPoint(x: x - size.height, y: size.height))
                        }
                    },
                    with: .color(color.opacity(0.5)),
                    lineWidth: 1
                )
            }
            .mask(EllipseShape()) // Маска для закорючки
        }
       // .frame(width: 400, height: 200) // Размер всей фигуры
    }
}

struct StripedDiamond: View {
  var color: Color
  
  init(color: Color) {
    self.color = color
  }
  
    var body: some View {
        ZStack {
            DiamondShape()
                .stroke(color, lineWidth: 2) // Обводка ромба
                //.frame(width: 200, height: 200)
            
            Canvas { context, size in
                let step: CGFloat = 10 // Расстояние между линиями
                let rect = CGRect(origin: .zero, size: size)
                
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
            .mask(DiamondShape()) // Ограничиваем линии рамками ромба
            //.frame(width: 200, height: 200)
        }
    }
}
