//
//  SetGameView.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 23.12.2024.
//

import SwiftUI

struct SetGameView: View {
  @ObservedObject var viewModel: SetGameViewModel
  private let aspectRatio: CGFloat = 2/3
  
  var body: some View {
    Text("Set Game").font(.largeTitle).bold()
    Text("Score: \(viewModel.currentScore)").font(.title2)
    cards
      .animation(.default, value: viewModel.cardsInGame)
    
    Button("Deal 3 More Cards") {
      viewModel.dealThreeMoreCards()
    }
    Button("Find set") {
      print(viewModel.findSets())
    }
    Button("New game") {
      viewModel.startNewGame()
    }
  }
  
  private var cards: some View {
    AspectVGrid(viewModel.cardsInGame, aspectRatio: aspectRatio) { card in
      let (count, figureView)  = viewModel.getCountAndFigureForCard(card)
      CardView(card: card, itemCount: count, figureView: figureView)
        .padding(15)
        .onTapGesture {
          viewModel.selectCard(card)
        }
    }
  }
  
  
  
}

struct CardView: View {
  let card: Card
  let itemCount: Int
  let figureView: any View
  
  var body: some View {
    
    ZStack {
      Rectangle()
        .fill(Color.white)
        .stroke(card.isSelected ? (card.isMismatched ? Color.red : (card.isMatched ? Color.green : Color.yellow)) : Color.gray, lineWidth: 5)
      VStack {
        ForEach(0..<itemCount, id: \.self) { _ in
          AnyView(figureView)
        }
      }
    }
    
  }
  
}

#Preview {
  SetGameView(viewModel: SetGameViewModel())
}
