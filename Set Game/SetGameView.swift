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
    cards
      .animation(.default, value: viewModel.cardsInGame)
    Button("Find set") {
      print(findSets(from: viewModel.cardsInGame))
    }
  }
  
  private var cards: some View {
    AspectVGrid(viewModel.cardsInGame, aspectRatio: aspectRatio) { card in
      CardView(card: card)
        .padding(15)
        .onTapGesture {
          print("GGWP")
          viewModel.selectCard(card)
        }
    }
  }
  
  
  
}

struct CardView: View {
  let card: Card
  
  var body: some View {
    let (count, figureView) = getCountAndFigureForCard(card)
    

    ZStack {
      Rectangle()
        .fill(Color.white)
        .stroke(card.isSelected ? (card.isMatched ? Color.green : Color.yellow) : Color.gray, lineWidth: 5)
      VStack {
        ForEach(0..<count, id: \.self) { _ in
          AnyView(figureView)
        }
      }
    }
    
  }
  
}

#Preview {
  SetGameView(viewModel: SetGameViewModel())
}
