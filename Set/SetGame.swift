//
//  SetGame.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import Foundation

struct SetGame<CardShape, CardColor, CardPattern, NumberOfShapes>{
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
                playingCards.append(Card(content: content))
            } else {
                cardDeck.append(Card(content: content))
            }
        }
    }
    
    struct Card {
        let content: CardContent
        let isFaceUp = false
        let isMatched = false
        
        struct CardContent {
            let shape: CardShape
            let color: CardColor
            let pattern: CardPattern
            let numberOfShapes: Int
        }
    }
}


