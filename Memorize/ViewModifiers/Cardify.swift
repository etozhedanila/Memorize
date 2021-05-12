//
//  Cardify.swift
//  Memorize
//
//  Created by Виталий Субботин on 12.05.2021.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFacedUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFacedUp {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .stroke(lineWidth: Constants.lineWidth)
                content
            } else {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill()
            }
        }
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}
