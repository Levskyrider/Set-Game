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
  }
  
  private var cards: some View {
    AspectVGrid(viewModel.cardsInGame, aspectRatio: aspectRatio) { card in
      CardView(card: card)
        .padding(4)
    }
  }
  
  
  
}

struct CardView: View {
  let card: Card
  
  var body: some View {
    let (count, figureView) = getCountAndFigureForCard(card)
    VStack {
      ForEach(0..<count, id: \.self) { _ in
        AnyView(figureView)
      }
    }
  }
  
}

#Preview {
  SetGameView(viewModel: SetGameViewModel())
}
