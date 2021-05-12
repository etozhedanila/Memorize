//
//  View + Cardify.swift
//  Memorize
//
//  Created by Виталий Субботин on 12.05.2021.
//

import SwiftUI

extension View {
    
    func cardify(isFacedUp: Bool) -> some View {
        return self.modifier(Cardify(isFacedUp: isFacedUp))
    }
}
