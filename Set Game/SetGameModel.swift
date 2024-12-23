//
//  CardsData.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 23.12.2024.
//

import Foundation
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

struct Card: Equatable, Identifiable {
  var id: String
  
  var figure: Figure
  var figuresCount: FiguresCount
  var figureFilling: FigureFilling
  var figureColor: FigureColor
}

struct SetGame {
  var allCards: [Card]
  
//  var selectedCards: [Card] = []
//  func checkIfSelectedCardsMadeSet() -> Bool {
//    
//    return false
//  }
  
  private static func generateAllCards() -> [Card] {
    let figures: [Figure] = [.diamond, .squiggle, .ellipse]
    let figuresCounts: [FiguresCount] = [.one, .two, .three]
    let figureFillings: [FigureFilling] = [.empty, .stripted, .filled]
    let furureColors: [FigureColor] = [.red, .green, .puprple]
    
    var cardsArray: [Card] = []
    var cardId = 0
    for figure in figures {
      for figuresCount in figuresCounts {
        for filling in figureFillings {
          for color in furureColors {
            cardsArray.append(Card(id: "\(cardId)", figure: figure, figuresCount: figuresCount, figureFilling: filling, figureColor: color))
            cardId += 1
          }
        }
      }
    }
    return cardsArray
  }
  
  init() {
    allCards = SetGame.generateAllCards()
  }
  
}
