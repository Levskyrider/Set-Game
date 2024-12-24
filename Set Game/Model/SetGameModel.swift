//
//  CardsData.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 23.12.2024.
//

import Foundation

struct SetGame {
  
  var allCards: [Card]
  var selectedCards: [Card] = []
  var matchedCards: [Card] = []
  var cardsInGame: [Card] = []
  
  init() {
    allCards = SetGame.generateAllCards()
    cardsInGame = Array(allCards.shuffled().prefix(12))
  }
  
  
  //MARK: - Generate all cards
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
  
  
  //MARK: - Card selection
  
  mutating func selectCard(_ card: Card) {
    //Remove card if it was selected before
    guard !selectedCards.compactMap({$0.id}).contains(card.id) else {
      deselectCard(card)
      return
    }
    
    if selectedCards.count < 3 {
      selectNewCard(card)
      
      if selectedCards.count == 3 {
        if checkIfCardsMatched() {
          for card in selectedCards {
            makeCardMatched(card)
          }
        } else {
          for card in selectedCards {
            makeCardMismatched(card)
          }
        }
      }
      
    } else if selectedCards.count == 3 {
      if checkIfCardsMatched() {
        changeMatchedCardsWithNewCards()
      } else {
        removeSelectionOfMismatchedCards()
      }
      selectedCards = []
      selectNewCard(card)
    }
  }
  
  
  //MARK: - Card selection process helpers
  
  mutating func selectNewCard(_ card: Card) {
    selectedCards.append(card)
    changeKeyArgumentsOfCard(card, isSelected: true)
  }
  
  mutating func deselectCard(_ card: Card) {
    changeKeyArgumentsOfCard(card, isSelected: false, isMatched: false, isMismatched: false)
    
    if let choosenIndex = selectedCards.firstIndex(where: { $0.id == card.id }) {
      selectedCards.remove(at: choosenIndex)
    }
  }
  
  
  
  mutating func makeCardMatched(_ card: Card) {
    changeKeyArgumentsOfCard(card, isMatched: true)
  }
  
  mutating func removeSelectionOfMismatchedCards() {
    for card in selectedCards {
      changeKeyArgumentsOfCard(card, isSelected: false, isMatched: false, isMismatched: false)
    }
  }
  
  mutating func makeCardMismatched(_ card: Card) {
    changeKeyArgumentsOfCard(card, isMismatched: true)
  }
  
  
  
  mutating func changeMatchedCardsWithNewCards() {
    var availableElements = allCards.filter { !selectedCards.contains($0) && !cardsInGame.contains($0) }.shuffled()
    
    for card in selectedCards {
      matchedCards.append(card)
      if let choosenIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
        if let newEl = availableElements.popLast() {
          cardsInGame[choosenIndex] = newEl
        }
      }
    }
  }
  
  
  func checkIfCardsMatched() -> Bool {
    return findSets(from: selectedCards).count > 0
  }

  
}



//MARK: - Quick change of arguments of card in all arrays
extension SetGame {
  mutating func changeKeyArgumentsOfCard(_ card: Card, isSelected: Bool? = nil, isMatched: Bool? = nil, isMismatched: Bool? = nil) {
    let indexInAllCards = allCards.firstIndex(where: { $0.id == card.id })
    let indexInCardsInGame = cardsInGame.firstIndex(where: { $0.id == card.id })
    let indexInSelectedCards = selectedCards.firstIndex(where: { $0.id == card.id })
    
    if let isSelected = isSelected {
      if let indexInAllCards = indexInAllCards {
        allCards[indexInAllCards].isSelected = isSelected
      }
      if let indexInCardsInGame = indexInCardsInGame {
        cardsInGame[indexInCardsInGame].isSelected = isSelected
      }
      if let indexInSelectedCards = indexInSelectedCards {
        selectedCards[indexInSelectedCards].isSelected = isSelected
      }
    }
    if let isMatched = isMatched {
      if let indexInAllCards = indexInAllCards {
        allCards[indexInAllCards].isMatched = isMatched
      }
      if let indexInCardsInGame = indexInCardsInGame {
        cardsInGame[indexInCardsInGame].isMatched = isMatched
      }
      if let indexInSelectedCards = indexInSelectedCards {
        selectedCards[indexInSelectedCards].isMatched = isMatched
      }
    }
    if let isMismatched = isMismatched {
      if let indexInAllCards = indexInAllCards {
        allCards[indexInAllCards].isMismatched = isMismatched
      }
      if let indexInCardsInGame = indexInCardsInGame {
        cardsInGame[indexInCardsInGame].isMismatched = isMismatched
      }
      if let indexInSelectedCards = indexInSelectedCards {
        selectedCards[indexInSelectedCards].isMismatched = isMismatched
      }
    }
  }
  
}


