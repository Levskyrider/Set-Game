//
//  ContentView.swift
//  Set Game
//
//  Created by Dmitro Levkutnyk on 18.12.2024.
//

import SwiftUI



//MARK: - Diamond




struct ContentView: View {
    var body: some View {
      StripedSquiggle(color: .red)
        .frame(width: 50, height: 80)
        
    }
}

#Preview {
    ContentView()
}
