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

struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
  var id: String
  
  var figure: Figure
  var figuresCount: FiguresCount
  var figureFilling: FigureFilling
  var figureColor: FigureColor
  
  var isSelected: Bool = false
  var isMatched: Bool = false
  
  var isMismatched: Bool = false
  
  var debugDescription: String {
    return "\(id): \(figure) \(figuresCount) \(figureFilling), \(figureColor)"
  }
}

struct SetGame {
  var allCards: [Card]
  
  var selectedCards: [Card] = []
  
  var matchedCards: [Card] = []
  
  var cardsInGame: [Card] = []
  

  

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
    cardsInGame = Array(allCards.shuffled().prefix(12))
  }
  
  mutating func selectCard(_ card: Card) {
    if let choosenIndex = allCards.firstIndex(where: { $0.id == card.id }) {
      
      if selectedCards.count < 3 {
        
        selectedCards.append(allCards[choosenIndex])
        allCards[choosenIndex].isSelected = true
        if let choosenIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
          cardsInGame[choosenIndex].isSelected = true
        }
        print("Ok")
        
        if selectedCards.count == 3 {
          if findSets(from: selectedCards).isEmpty {
            for card in selectedCards {
              if let cardIndex = allCards.firstIndex(where: { $0.id == card.id }) {
                allCards[cardIndex].isMismatched = true
              }
            }
          } else {
            for card in selectedCards {
              if let cardIndex = allCards.firstIndex(where: { $0.id == card.id }) {
                allCards[cardIndex].isMatched = true
                if let cardIndex = selectedCards.firstIndex(where: { $0.id == card.id }) {
                  selectedCards[cardIndex].isMatched = true
                  if let cardIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
                    cardsInGame[cardIndex].isMatched = true
                  }
                }
                print("Card matched")
              }
            }
            
          }
          return
        }
        
      } else if selectedCards.count == 3 {
        
        var allCardsMatcherd = true
        for card in selectedCards{
          if !card.isMatched {
            allCardsMatcherd = false
            print("OMASUSDNSDKNSKD")
          }
        }
        if allCardsMatcherd {
          //Заменить карты
          var availableElements = allCards.filter { !selectedCards.contains($0) && !cardsInGame.contains($0) }.shuffled()

          for card in selectedCards {
            matchedCards.append(card)
            if let choosenIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
              if let newEl = availableElements.popLast() {
                cardsInGame[choosenIndex] = newEl
              }
            }
          }
          
          selectedCards = []
          
          selectedCards.append(allCards[choosenIndex])
          allCards[choosenIndex].isSelected = true
          if let choosenIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
            cardsInGame[choosenIndex].isSelected = true
          }
          
        } else {
          for card in selectedCards {
            if let choosenIndex = allCards.firstIndex(where: { $0.id == card.id }) {
              allCards[choosenIndex].isSelected = false
              allCards[choosenIndex].isMatched = false
              allCards[choosenIndex].isMismatched = false
            }
          }
          selectedCards = []
          
          selectedCards.append(allCards[choosenIndex])
          allCards[choosenIndex].isSelected = true
          if let choosenIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
            cardsInGame[choosenIndex].isSelected = true
          }
        }
        
      } else {
        
        //MARK: - Maybe dont need this
        selectedCards.append(allCards[choosenIndex])
        allCards[choosenIndex].isSelected = true
        if let choosenIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
          cardsInGame[choosenIndex].isSelected = true
        }
      }
    }
    
  }
}


func findSets(from cards: [Card]) -> [[Card]] {
    var sets: [[Card]] = []
    
    // Перебираем все возможные тройки карт
    for i in 0..<cards.count {
        for j in i+1..<cards.count {
            for k in j+1..<cards.count {
                let card1 = cards[i]
                let card2 = cards[j]
                let card3 = cards[k]
                
                // Проверяем, образуют ли эти карты сет
                if isSet(card1, card2, card3) {
                    sets.append([card1, card2, card3])
                }
            }
        }
    }
    
    return sets
}

// Функция для проверки, образуют ли три карты сет
func isSet(_ card1: Card, _ card2: Card, _ card3: Card) -> Bool {
    // Проверяем для каждой характеристики (фигура, количество, заполнение, цвет)
    return isSameOrDifferent(card1.figure, card2.figure, card3.figure) &&
           isSameOrDifferent(card1.figuresCount, card2.figuresCount, card3.figuresCount) &&
           isSameOrDifferent(card1.figureFilling, card2.figureFilling, card3.figureFilling) &&
           isSameOrDifferent(card1.figureColor, card2.figureColor, card3.figureColor)
}

// Функция для проверки, одинаковы ли все элементы или все разные
func isSameOrDifferent<T: Equatable>(_ value1: T, _ value2: T, _ value3: T) -> Bool {
    return (value1 == value2 && value2 == value3) || (value1 != value2 && value2 != value3 && value1 != value3)
}
