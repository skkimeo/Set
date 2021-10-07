//
//  SetGame.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import Foundation

struct SetGame<CardContentShape, CardContentColor, CardContentPattern, NumberOfShapes>{
    private(set) var cardDeck: [Card]
    private(set) var playingCards: [Card]
    
    mutating func choose(_ card: Card) {
        
    }
    
    mutating func deal_three_cards() {
        
    }
    
    init(createCardContent: (Int) -> Card.CardContent) {
        cardDeck = []
        playingCards = []
        for index in 0..<81 {
            let content = createCardContent(index)
            if index < 12 {
                playingCards.append(Card(content: content, id: index))
            } else {
                cardDeck.append(Card(content: content, id: index))
            }
        }
    }
    
    struct Card: Identifiable {
        let content: CardContent
        let isFaceUp = true
        let isMatched = false
        let id: Int
        
        struct CardContent {
            let shape: CardContentShape
            let color: CardContentColor
            let pattern: CardContentPattern
            let numberOfShapes: Int
        }
    }
}


