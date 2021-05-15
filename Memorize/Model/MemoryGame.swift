//
//  MemoryGame.swift
//  Memorize
//
//  Created by Виталий Субботин on 07.05.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: [Card]
    
    private var facedUpCardIndex: Int? {
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
        var isFacedUp = false {
            didSet {
                isFacedUp ? startUsingBonusTime() : stopUsingBonusTime()
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        
        // Mark: - Bonus Time
        
        var bonusTimeLimit: TimeInterval = 6
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFacedUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            guard isConsumingBonusTime, lastFaceUpDate == nil else { return }
            lastFaceUpDate = Date()
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
