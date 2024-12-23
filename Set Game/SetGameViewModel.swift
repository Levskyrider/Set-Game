//
//  SetGameViewModel.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 23.12.2024.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
  @Published private var model: SetGame
  
  var cardsInGame: [Card] = []
  
  init() {
    self.model = SetGame()
    cardsInGame = Array(model.allCards.shuffled().prefix(12))
  }
  

  
}

func getCountAndFigureForCard(_ card: Card) -> (Int, any View) {
  let count = card.figuresCount.rawValue
 
    switch card.figure {
      case .diamond:
      if card.figureFilling == .stripted {
        return (count, StripedDiamond(color: card.figureColor.getColor()))
      } else {
        return (count, DiamondShape().stroke(card.figureColor.getColor(), lineWidth: 5)
          .fill(card.figureFilling == .filled ? card.figureColor.getColor() : Color.clear))
      }
      case .squiggle:
      if card.figureFilling == .stripted {
        return (count, StripedSquiggle(color: card.figureColor.getColor()))
      } else {
        return (count, SquiggleShape().stroke(card.figureColor.getColor(), lineWidth: 5)
          .fill(card.figureFilling == .filled ? card.figureColor.getColor() : Color.clear))
      }
      case .ellipse:
      if card.figureFilling == .stripted {
        return (count, StripedEllipse(color: card.figureColor.getColor()))
      } else {
        return (count, EllipseShape().stroke(card.figureColor.getColor(), lineWidth: 5)
          .fill(card.figureFilling == .filled ? card.figureColor.getColor() : Color.clear))
      }
    }
}
