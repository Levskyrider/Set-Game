//
//  FindSetsFunctions.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 24.12.2024.
//

import Foundation

extension SetGame {
  
  func findSets(from cards: [Card]) -> [[Card]] {
    var sets: [[Card]] = []
    
    for i in 0..<cards.count {
      for j in i+1..<cards.count {
        for k in j+1..<cards.count {
          let card1 = cards[i]
          let card2 = cards[j]
          let card3 = cards[k]
          
          if isSet(card1, card2, card3) {
            sets.append([card1, card2, card3])
          }
        }
      }
    }
    
    return sets
  }
  
  func isSet(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
    return isSameOrDifferent(card1.figure, card2.figure, card3.figure) &&
    isSameOrDifferent(card1.figuresCount, card2.figuresCount, card3.figuresCount) &&
    isSameOrDifferent(card1.figureFilling, card2.figureFilling, card3.figureFilling) &&
    isSameOrDifferent(card1.figureColor, card2.figureColor, card3.figureColor)
  }
  
  func isSameOrDifferent<T: Equatable>(_ value1: T, _ value2: T, _ value3: T) -> Bool {
    return (value1 == value2 && value2 == value3) || (value1 != value2 && value2 != value3 && value1 != value3)
  }
  
}
