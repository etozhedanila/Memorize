//
//  MemoryGame.swift
//  Memorize
//
//  Created by Виталий Субботин on 07.05.2021.
//

import Foundation

struct MemoryGame<CardContent> {
    
    var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        self.cards = []
        (0..<numberOfPairsOfCards).forEach {
            let content = cardContentFactory($0)
            cards.append(.init(id: 2 * $0, content: content))
            cards.append(.init(id: 2 * $0 + 1, content: content))
        }
    }
    
    func choose(card: Card) {
        print("\(card)")
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFacedUp = true
        var isMatched = false
        var content: CardContent
    }
}
