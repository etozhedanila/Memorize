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
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFacedUp || !card.isMatched {
            ZStack {
                Pie(startAngle: .degrees(-90), endAngle: .degrees(20), clockwise: true)
                    .padding(Constants.piePadding)
                    .opacity(Constants.pieOpacity)
                Text(card.content)
                    .font(.system(size: fontSize(for: size)))
            }
            .cardify(isFacedUp: card.isFacedUp)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * Constants.fontScaleFactor
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let piePadding: CGFloat = 5
        static let pieOpacity: Double = 0.4
        static let fontScaleFactor: CGFloat = 0.7
    }
}

