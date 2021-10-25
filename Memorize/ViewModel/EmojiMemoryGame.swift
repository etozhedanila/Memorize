//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Виталий Субботин on 07.05.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published
    private var model = EmojiMemoryGame.makeMemoryGame()
    
    private static func makeMemoryGame() -> MemoryGame<String> {
        let emojis = ["🌚", "❤️", "🏎", "💩", "🐔", "🌈"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            emojis[pairIndex]
        }
    }
    // MARK: - Access to the Model
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func close(card: MemoryGame<String>.Card) {
        model.close(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.makeMemoryGame()
    }
}
