//
//  CardView.swift
//  Memorize
//
//  Created by Виталий Субботин on 11.05.2021.
//

import SwiftUI

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFacedUp {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(lineWidth: Constants.lineWidth)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .fill()
                }
            }
        }
        .font(.system(size: fontSize(for: size)))
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * Constants.fontScaleFactor
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScaleFactor: CGFloat = 0.75
    }
}

