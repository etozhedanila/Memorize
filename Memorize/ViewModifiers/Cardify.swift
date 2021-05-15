//
//  Cardify.swift
//  Memorize
//
//  Created by Виталий Субботин on 12.05.2021.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var rotation: Double
    
    var isFacedUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    init(isFacedUp: Bool) {
        rotation = isFacedUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(lineWidth: Constants.lineWidth)
                content
            }
            .opacity(isFacedUp ? 1 : 0)
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill()
                .opacity(isFacedUp ? 0 : 1)
        }
        .rotation3DEffect(
            .degrees(rotation),
            axis: (x: 0, y: 1.0, z: 0)
        )
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}
