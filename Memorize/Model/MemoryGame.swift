//
//  MemoryGame.swift
//  Memorize
//
//  Created by Виталий Субботин on 07.05.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    var cards: [Card]
    
    var facedUpCardIndex: Int? {
        get {
            cards.indices.filter { cards[$0].isFacedUp }.only
        }
        set {
            cards = cards.enumerated().map {
                Card(
                    id: $0.element.id,
                    isFacedUp: newValue == $0.offset,
                    isMatched: $0.element.isMatched,
                    content: $0.element.content)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        self.cards = []
        (0..<numberOfPairsOfCards).forEach {
            let content = cardContentFactory($0)
            cards.append(.init(id: 2 * $0, content: content))
            cards.append(.init(id: 2 * $0 + 1, content: content))
        }
        self.cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        guard
            let chosenIndex = cards.firstIndex(of: card),
            !cards[chosenIndex].isFacedUp,
            !cards[chosenIndex].isMatched
        else { return }
        
        if let facedUpCardIndex = facedUpCardIndex {
            if cards[facedUpCardIndex].content == cards[chosenIndex].content {
                cards[facedUpCardIndex].isMatched = true
                cards[chosenIndex].isMatched = true
            }
            cards[chosenIndex].isFacedUp = true
        } else {
            self.facedUpCardIndex = chosenIndex
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFacedUp = false
        var isMatched = false
        var content: CardContent
    }
}
