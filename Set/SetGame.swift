//
//  SetGame.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import Foundation

struct SetGame<CardSymbolShape, CardSymbolColor, CardSymbolPattern, NumberOfShapes> where CardSymbolShape: Hashable, CardSymbolColor: Hashable, CardSymbolPattern: Hashable {
    private var numberOfPlayingCards = 0
    private var numberOfChosenCards = 0
    private var chosenCards = [Card]()
    
    private let totalNumberOfCards = 81
    private let initialNumberOfPlayingCards = 12
    
    private let createCardSymbol: (Int) -> Card.CardContent
    private(set) var playingCards: [Card]
    
    mutating func choose(_ card: Card) {
        if chosenCards.count == 3 {
            if findSet() { // think of way to simplify
                // erase those in set
                chosenCards.forEach { card in
                    let matchedIndex = playingCards.firstIndex(of: card)!
                    playingCards.remove(at: matchedIndex)
                }
                deal_three_cards()
            }
            else {
                chosenCards.forEach { card in
                    let failedMatchIndex = playingCards.firstIndex(of: card)!
                    playingCards[failedMatchIndex].isChosen = false
                    playingCards[failedMatchIndex].isNotMatched = false
                }
            }
            chosenCards = []
        }
        //        else { //
        if let chosenIndex = playingCards.firstIndex(where: { $0.id == card.id }) {
            if !playingCards[chosenIndex].isChosen {
                playingCards[chosenIndex].isChosen = true
                chosenCards.append(playingCards[chosenIndex])
                
                if chosenCards.count == 3 {
                    if findSet() {
                        chosenCards.forEach { card in
                            let index = playingCards.firstIndex(of: card)!
                            playingCards[index].isMatched = true
                        }
                    } else {
                        chosenCards.forEach { card in
                            let index = playingCards.firstIndex(of: card)!
                            playingCards[index].isNotMatched = true
                        }
                    }
                }
            } else { // diselect
                playingCards[chosenIndex].isChosen = false
                chosenCards.remove(at: chosenCards.firstIndex(of: playingCards[chosenIndex])!)
                
            }
        }
        
        //        }
    }
                 
    
    mutating func findSet() -> Bool {
        var shapes = Set<CardSymbolShape>()
        var colors = Set<CardSymbolColor>()
        var patterns = Set<CardSymbolPattern>()
        var numberOfShapes = Set<Int>()
        
        chosenCards.forEach { card in
            shapes.insert(card.symbol.shape)
            colors.insert(card.symbol.color)
            patterns.insert(card.symbol.pattern)
            numberOfShapes.insert(card.symbol.numberOfShapes)
        }
        
        if shapes.count == 2 || colors.count == 2 ||
            patterns.count == 2 || numberOfShapes.count == 2 {
            return false
        }
        return true
    }
    
    mutating func deal_three_cards() {
        if numberOfPlayingCards < totalNumberOfCards {
            if findSet() {
                
            }
            for _ in 0..<3 {
                let content = createCardSymbol(numberOfPlayingCards)
                playingCards.append(Card(symbol: content, id: numberOfPlayingCards))
                numberOfPlayingCards += 1
            }
        }
    }
    
    init(createCardContent: @escaping (Int) -> Card.CardContent) {
        self.createCardSymbol = createCardContent
        playingCards = []
        for _ in 0..<initialNumberOfPlayingCards {
            let content = createCardContent(numberOfPlayingCards)
            playingCards.append(Card(symbol: content, id: numberOfPlayingCards))
            numberOfPlayingCards += 1
        }
    }
    
    struct Card: Identifiable, Equatable {
        let symbol: CardContent
        var isChosen: Bool = false
        var isMatched = false
        var isNotMatched = false
        let id: Int
        
        struct CardContent {
            let shape: CardSymbolShape
            let color: CardSymbolColor
            let pattern: CardSymbolPattern
            let numberOfShapes: Int
        }
        
        static func == (lhs: SetGame<CardSymbolShape, CardSymbolColor, CardSymbolPattern, NumberOfShapes>.Card, rhs: SetGame<CardSymbolShape, CardSymbolColor, CardSymbolPattern, NumberOfShapes>.Card) -> Bool {
            lhs.id == rhs.id
        }
        
    }
}


