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
  
  mutating func deselectCard(_ card: Card) {
    if let choosenIndex = allCards.firstIndex(where: { $0.id == card.id }) {
      allCards[choosenIndex].isSelected = false
    }
    if let choosenIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
      cardsInGame[choosenIndex].isSelected = false
    }
    if let choosenIndex = selectedCards.firstIndex(where: { $0.id == card.id }) {
      selectedCards[choosenIndex].isSelected = false
      selectedCards.remove(at: choosenIndex)
    }
  }
  
  mutating func selectNewCard(_ card: Card) {
    selectedCards.append(card)
    if let choosenIndex = allCards.firstIndex(where: { $0.id == card.id }) {
      allCards[choosenIndex].isSelected = true
    }
    if let choosenIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
      cardsInGame[choosenIndex].isSelected = true
    }
  }
  
  func checkIfCardsMatched() -> Bool {
    return findSets(from: selectedCards).count > 0
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
  
  mutating func makeCardMatched(_ card: Card) {
    if let cardIndex = allCards.firstIndex(where: { $0.id == card.id }) {
      allCards[cardIndex].isMatched = true
    }
    if let cardIndex = selectedCards.firstIndex(where: { $0.id == card.id }) {
      selectedCards[cardIndex].isMatched = true
    }
    if let cardIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
      cardsInGame[cardIndex].isMatched = true
    }
  }
  
  mutating func removeSelectionOfMismatchedCards() {
    for card in selectedCards {
      if let choosenIndex = allCards.firstIndex(where: { $0.id == card.id }) {
        allCards[choosenIndex].isSelected = false
        allCards[choosenIndex].isMatched = false
        allCards[choosenIndex].isMismatched = false
      }
      if let choosenIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
        cardsInGame[choosenIndex].isSelected = false
        cardsInGame[choosenIndex].isMatched = false
        cardsInGame[choosenIndex].isMismatched = false
      }
    }
  }
  
  mutating func makeCardMismatched(_ card: Card) {
    if let cardIndex = allCards.firstIndex(where: { $0.id == card.id }) {
      allCards[cardIndex].isMismatched = true
    }
    if let cardIndex = cardsInGame.firstIndex(where: { $0.id == card.id }) {
      cardsInGame[cardIndex].isMismatched = true
    }
    if let cardIndex = selectedCards.firstIndex(where: { $0.id == card.id }) {
      selectedCards[cardIndex].isMismatched = true
    }
  }
  
  
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
        //Заменить карты
        changeMatchedCardsWithNewCards()
        
        selectedCards = []
        selectNewCard(card)
        
      } else {
        removeSelectionOfMismatchedCards()
        
        selectedCards = []
        selectNewCard(card)
      }
      
    }
  }
  
  
}


