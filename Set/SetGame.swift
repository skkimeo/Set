//
//  SetGame.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import Foundation

struct SetGame<CardContentShape, CardContentColor, CardContentPattern, NumberOfShapes>{
    private var numberOfPlayingCards = 0
    private var numberOfChosenCards = 0
    private var chosenCards = [Int]()
    
    private let totalNumberOfCards = 81
    private let initialNumberOfPlayingCards = 3
    
    private let createCardContent: (Int) -> Card.CardContent
    private(set) var playingCards: [Card]
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = playingCards.firstIndex(where: {$0.id == card.id}) {
            switch chosenCards.count {
            case 3:
                // 기존 3개가 매칭인지 확인해야함
                if !playingCards[chosenIndex].isChosen {
                    // match checking method
                    chosenCards.forEach {
                        playingCards.remove(at: $0)
                    }
                    chosenCards = []
                    playingCards[chosenIndex].isChosen = true
                    chosenCards.append(chosenIndex)
                }
                
            default:
                if !playingCards[chosenIndex].isChosen {
                    playingCards[chosenIndex].isChosen = true
                    chosenCards.append(chosenIndex)
                    
                } else {  // diselect
                    playingCards[chosenIndex].isChosen = false
                    chosenCards.remove(at: chosenCards.firstIndex(of: chosenIndex)!)
                }
            }
            
        }
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
        for _ in 0..<initialNumberOfPlayingCards {
            let content = createCardContent(numberOfPlayingCards)
            playingCards.append(Card(content: content, id: numberOfPlayingCards))
            numberOfPlayingCards += 1
        }
    }
    
    struct Card: Identifiable {
        let content: CardContent
        var isChosen = false
        var isMatched = false
        let id: Int
        
        struct CardContent {
            let shape: CardContentShape
            let color: CardContentColor
            let pattern: CardContentPattern
            let numberOfShapes: Int
        }
    }
}


