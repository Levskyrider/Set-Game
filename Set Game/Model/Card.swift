//
//  Card.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 24.12.2024.
//

import SwiftUI

enum Figure {
  case diamond
  case squiggle
  case ellipse
}

enum FiguresCount: Int {
  case one = 1
  case two = 2
  case three = 3
}

enum FigureFilling {
  case empty
  case stripted
  case filled
}

enum FigureColor {
  case red
  case green
  case puprple
  
  func getColor() -> Color {
    switch self {
    case .red: return Color.red
    case .green: return Color.green
    case .puprple: return Color.purple
    }
  }
}

enum CardGameStatus {
  case inStock
  case inGame
  case isMatched
}

struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
  var id: String
  
  var figure: Figure
  var figuresCount: FiguresCount
  var figureFilling: FigureFilling
  var figureColor: FigureColor
  
  var isSelected: Bool = false
  var isMatched: Bool = false
  
  //When in set and all cards mismatched
  var isMismatched: Bool = false
  
  var cardGameStatus: CardGameStatus = .inStock
  
  var debugDescription: String {
    return "\(id): \(figure) \(figuresCount) \(figureFilling), \(figureColor)"
  }
}
