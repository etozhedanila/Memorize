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
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFacedUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: .degrees(-90), endAngle: .degrees(-animatedBonusRemaining * 360 - 90), clockwise: true)
                            .onAppear {
                                startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: .degrees(-90), endAngle: .degrees(-card.bonusRemaining * 360 - 90), clockwise: true)
                    }
                }
                .padding(Constants.piePadding)
                .opacity(Constants.pieOpacity)
                Text(card.content)
                    .font(.system(size: fontSize(for: size)))
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: Constants.rotationDuration).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFacedUp: card.isFacedUp)
            .transition(.scale)
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * Constants.fontScaleFactor
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let rotationDuration: Double = 1.0
        static let piePadding: CGFloat = 5
        static let pieOpacity: Double = 0.4
        static let fontScaleFactor: CGFloat = 0.7
    }
}

