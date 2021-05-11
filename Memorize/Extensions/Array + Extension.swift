//
//  Array + Extension.swift
//  Memorize
//
//  Created by Виталий Субботин on 11.05.2021.
//

import Foundation

extension Array where Element: Identifiable {
    
    func firstIndex(of item: Element) -> Int? {
        return self.firstIndex { $0.id == item.id }
    }
}

extension Array {
    
    var only: Element? {
        count == 1 ? first : nil
    }
}
