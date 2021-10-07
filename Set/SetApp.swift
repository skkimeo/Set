//
//  SetApp.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import SwiftUI

@main
struct SetApp: App {
    let game = SquareSetGame()
    var body: some Scene {
        WindowGroup {
            SquareSetGameView(game: game)
        }
    }
}
