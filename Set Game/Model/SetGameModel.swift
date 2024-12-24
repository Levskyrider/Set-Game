//
//  CardsData.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 23.12.2024.
//

import Foundation

struct SetGame {
  
  var allCards: [String: Card] // Dictionary with cards with access by ID
  var selectedCards: [String] = []
  var matchedCards: [String] = []
  var cardsInGame: [String] = []
  
  var cardsInGameRepresenting: [Card] {
    cardsInGame.compactMap { allCards[$0] }
  }
  
  init() {
    let cards = SetGame.generateAllCards()
    allCards = Dictionary(uniqueKeysWithValues: cards.map { ($0.id, $0) })
    cardsInGame = Array(allCards.keys.shuffled().prefix(12))
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
    guard !selectedCards.compactMap({$0}).contains(card.id) else {
      deselectCard(card)
      return
    }
    
    if selectedCards.count < 3 {
      selectNewCard(card)
      
      if selectedCards.count == 3 {
        let cardsMatched = checkIfCardsMatched()
        for cardId in selectedCards {
          if cardsMatched {
            changeKeyArgumentsOfCard(withId: cardId, isMatched: true)
          } else {
            changeKeyArgumentsOfCard(withId: cardId, isMismatched: true)
          }
        }
      }
      
    } else if selectedCards.count == 3 {
      if checkIfCardsMatched() {
        changeMatchedCardsWithNewCards()
      } else {
        for cardId in selectedCards {
          changeKeyArgumentsOfCard(withId: cardId, isSelected: false, isMatched: false, isMismatched: false)
        }
      }
      selectedCards = []
      selectNewCard(card)
    }
  }
  
  
  //MARK: - Card selection process helpers
  
  mutating func selectNewCard(_ card: Card) {
    selectedCards.append(card.id)
    changeKeyArgumentsOfCard(withId: card.id, isSelected: true)
  }
  
  mutating func deselectCard(_ card: Card) {
    changeKeyArgumentsOfCard(withId: card.id, isSelected: false, isMatched: false, isMismatched: false)
    
    if let choosenIndex = selectedCards.firstIndex(where: { $0 == card.id }) {
      selectedCards.remove(at: choosenIndex)
    }
  }
  
  mutating func changeMatchedCardsWithNewCards() {
    var availableElements = allCards.filter { !selectedCards.contains($0.key) && !cardsInGame.contains($0.key) }.shuffled()
    
    for cardId in selectedCards {
      matchedCards.append(cardId)
      if let choosenIndex = cardsInGame.firstIndex(where: { $0 == cardId }) {
        if let newEl = availableElements.popLast() {
          cardsInGame[choosenIndex] = newEl.key
        }
      }
    }
  }
  
  
  func checkIfCardsMatched() -> Bool {
    let selectedCards = selectedCards.compactMap { allCards[$0] }
    return findSets(from: selectedCards).count > 0
  }
  
}



//MARK: - Quick change of arguments of card in all arrays
extension SetGame {
  mutating func changeKeyArgumentsOfCard(
    withId id: String,
    isSelected: Bool? = nil,
    isMatched: Bool? = nil,
    isMismatched: Bool? = nil
  ) {
    guard var card = allCards[id] else { return }
    
    if let isSelected = isSelected { card.isSelected = isSelected }
    if let isMatched = isMatched { card.isMatched = isMatched }
    if let isMismatched = isMismatched { card.isMismatched = isMismatched }
    
    allCards[id] = card
  }
}
