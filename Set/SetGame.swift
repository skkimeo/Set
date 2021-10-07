//
//  SetGame.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import Foundation

struct SetGame<CardContentShape, CardContentColor, CardContentPattern, NumberOfShapes>{
    private var numberOfPlayingCards: Int
    private let totalNumberOfCards = 81
    private let initialNumberOfPlayingCards = 12
    private let createCardContent: (Int) -> Card.CardContent
    private(set) var playingCards: [Card]
    
    mutating func choose(_ card: Card) {
        
    }
    
    mutating func deal_three_cards() {
        if numberOfPlayingCards < totalNumberOfCards {
            for _ in 0..<3 {
                let content = createCardContent(numberOfPlayingCards)
                playingCards.append(Card(content: content, id: numberOfPlayingCards))
                numberOfPlayingCards += 1
            }
        }
    }
    
    init(createCardContent: @escaping (Int) -> Card.CardContent) {
        self.createCardContent = createCardContent
        playingCards = []
        for index in 0..<initialNumberOfPlayingCards {
            let content = createCardContent(index)
            playingCards.append(Card(content: content, id: index))
        }
        numberOfPlayingCards = 12
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


