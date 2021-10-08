//
//  SetGame.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import Foundation

struct SetGame<CardSymbolShape, CardSymbolColor, CardSymbolPattern, NumberOfShapes> where CardSymbolShape: Hashable, CardSymbolColor: Hashable, CardSymbolPattern: Hashable {
    private(set) var numberOfPlayedCards = 0
    private var numberOfChosenCards = 0
    private var chosenCards = [Card]()
    private(set) var isEndOfGame = false
    
    let totalNumberOfCards = 81
    private let initialNumberOfPlayingCards = 12
    
    private let createCardSymbol: (Int) -> Card.CardContent
    private(set) var playingCards: [Card]
    
    mutating func choose(_ card: Card) {
        if isEndOfGame {
            return
        }
                
        if chosenCards.count == 3 {
            if playingCards.first(where: {$0 == chosenCards.first})!.isMatched { // think of way to simplify
                // erase those in set
                chosenCards.forEach { card in
                    let matchedIndex = playingCards.firstIndex(of: card)!
                    playingCards.remove(at: matchedIndex)
                    deal_a_card(at: matchedIndex)
                }
                
//                if numberOfPlayedCards == totalNumberOfCards {
//                    if checkIfEndOfGame(in: playingCards) {
//                        isEndOfGame = true
//                        return
//                    }
//                }
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
                    if findSet(of: chosenCards) {
                        chosenCards.forEach { card in
                            let index = playingCards.firstIndex(of: card)!
                            playingCards[index].isMatched = true
                        }
                        
                        if numberOfPlayedCards == totalNumberOfCards {
                            var dupPlayingCards = playingCards
                            chosenCards.forEach { card in
                                let matchedIndex = dupPlayingCards.firstIndex(of: card)!
                                dupPlayingCards.remove(at: matchedIndex)
                            }
                            
                            if dupPlayingCards.isEmpty || checkIfEndOfGame(in: dupPlayingCards) {
                                isEndOfGame = true
                            }
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
    
    mutating func checkIfEndOfGame(in cards: [Card]) -> Bool {
        
        for i in 0..<cards.count - 2 {
            for j in (i + 1)..<cards.count - 1 {
                for k in (j + 1)..<cards.count {
                    if findSet(of: [cards[i], cards[j], cards[k]]) {
                        return false
                    }
                }
            }
        }
        return true
    }
                 
    
    mutating func findSet(of cards: [Card]) -> Bool {
        var shapes = Set<CardSymbolShape>()
        var colors = Set<CardSymbolColor>()
        var patterns = Set<CardSymbolPattern>()
        var numberOfShapes = Set<Int>()
        
        cards.forEach { card in
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
    
    mutating func deal_a_card(at index: Int) {
        if numberOfPlayedCards < totalNumberOfCards {
            let symbol = createCardSymbol(numberOfPlayedCards)
            playingCards.insert(Card(symbol: symbol, id: numberOfPlayedCards), at: index)
            numberOfPlayedCards += 1
        }
    }
    
    mutating func dealThreeCards() {
        if chosenCards.count == 3 {
            let chosenCard = playingCards.first(where: {$0 == chosenCards.first})!
            if chosenCard.isMatched {
                chosenCards.forEach { card in
                    let matchedIndex = playingCards.firstIndex(of: card)!
                    playingCards.remove(at: matchedIndex)
                    deal_a_card(at: matchedIndex)
                }
            } else {
                chosenCards.forEach { card in
                    let failedMatchIndex = playingCards.firstIndex(of: card)!
                    playingCards[failedMatchIndex].isChosen = false
                    playingCards[failedMatchIndex].isNotMatched = false
                }
                for _ in 0..<3 {
                    deal_a_card(at: playingCards.endIndex)
                }
            }
            chosenCards = []

        } else {
            for _ in 0..<3 {
                deal_a_card(at: playingCards.endIndex)
            }
        }
        
        if numberOfPlayedCards == totalNumberOfCards {
            if checkIfEndOfGame(in: playingCards) {
                isEndOfGame = true
            }
        }
    }
    
    init(createCardContent: @escaping (Int) -> Card.CardContent) {
        self.createCardSymbol = createCardContent
        playingCards = []
        for _ in 0..<initialNumberOfPlayingCards {
            let content = createCardContent(numberOfPlayedCards)
            playingCards.append(Card(symbol: content, id: numberOfPlayedCards))
            numberOfPlayedCards += 1
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


