//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Виталий Субботин on 07.05.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card)
                .onTapGesture {
                    viewModel.choose(card: card)
                }
                .padding(Constants.cardPadding)
        }
        .foregroundColor(.orange)
        .accessibilityHint("OOO")
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let cardPadding: CGFloat = 5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
