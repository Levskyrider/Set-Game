//
//  SetGameViewModel.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 23.12.2024.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
  @Published private var model: SetGame
  
  var cardsInGame: [Card] {
    get {
      return model.cardsInGameRepresenting
    }
  }
  
  init() {
    self.model = SetGame()
  }
  
  func selectCard(_ card: Card) {
    model.selectCard(card)
  }
  
  func getCountAndFigureForCard(_ card: Card) -> (count: Int, figureView: any View) {
    let count = card.figuresCount.rawValue
    
    func createView(for shape: some Shape, color: Color, filling: FigureFilling) -> any View {
      switch filling {
      case .stripted:
        return StripedShape(color: color, shape: shape)
      case .filled:
        return shape.fill(color)
      case .empty:
        return shape.stroke(color, lineWidth: 5)
      }
    }
    
    let viewToReturn: any View
    let color = card.figureColor.getColor()
    
    switch card.figure {
    case .diamond:
      viewToReturn = createView(for: DiamondShape(), color: color, filling: card.figureFilling)
    case .squiggle:
      viewToReturn = createView(for: SquiggleShape(), color: color, filling: card.figureFilling)
    case .ellipse:
      viewToReturn = createView(for: EllipseShape(), color: color, filling: card.figureFilling)
    }
    
    return (count, viewToReturn)
  }
  
  //MARK: - Cheat
  func findSets() -> [[Card]] {
    model.findSets(from: cardsInGame)
  }
  
  
}
