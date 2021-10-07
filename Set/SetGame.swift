//
//  SetGame.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import Foundation

struct SetGame<CardContent>{
    private(set) var cards: [Card]
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        let Content: CardContent  // shape, color, pattern
        let isFaceUp = false
        let isMatched = false
    }
}


