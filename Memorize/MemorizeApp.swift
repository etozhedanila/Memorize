//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Виталий Субботин on 07.05.2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            ContentView(viewModel: game)
        }
    }
}
