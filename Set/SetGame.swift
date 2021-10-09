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
    
    private(set) var totalNumberOfCards: Int
    private var initialNumberOfPlayingCards: Int
    
    private let createCardSymbol: (Int) -> Card.CardContent
    private(set) var playingCards: [Card]
    private(set) var remainingSet: [Card]?
    
    private(set) var score = 0
    
    private(set) var timeLastThreeCardsWereChosen = Date()
    
    mutating func choose(_ card: Card) {
        turnOffCheat()
        //        if isEndOfGame {
        //            return
        //        }
        
        if chosenCards.count == 3 {
            if playingCards.first(where: {$0 == chosenCards.first})!.isMatched { // think of way to simplify
                // erase those in set
                chosenCards.forEach { card in
                    let matchedIndex = playingCards.firstIndex(of: card)!
                    playingCards.remove(at: matchedIndex)
                    deal_a_card(at: matchedIndex)
                }
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
        if let chosenIndex = playingCards.firstIndex(where: { $0.id == card.id }) {
            if !playingCards[chosenIndex].isChosen {
                playingCards[chosenIndex].isChosen = true
                chosenCards.append(playingCards[chosenIndex])
                
                if chosenCards.count == 3 {
                    
                    let timeNewSetWasFound = Date()
                    let timeSpent = Int(timeNewSetWasFound.timeIntervalSince(timeLastThreeCardsWereChosen))
                    
                    if checkSet(in: chosenCards) {
                        score += 2 * max(20 - timeSpent, 1)
                        
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
                            
                            if dupPlayingCards.isEmpty || getRemainingSet(in: playingCards) == nil {
                                isEndOfGame = true
                            }
                        }
                        
                    } else {
                        score -= 2 * max(20 - timeSpent, 1)
                        chosenCards.forEach { card in
                            let index = playingCards.firstIndex(of: card)!
                            playingCards[index].isNotMatched = true
                        }
                    }
                    timeLastThreeCardsWereChosen = timeNewSetWasFound
                }
            } else { // diselect
                playingCards[chosenIndex].isChosen = false
                chosenCards.remove(at: chosenCards.firstIndex(of: playingCards[chosenIndex])!)
            }
            
        }
        
    }
    
    mutating func getRemainingSet(in cards: [Card]) -> [Card]? {
        
        for i in 0..<cards.count - 2 {
            for j in (i + 1)..<cards.count - 1 {
                for k in (j + 1)..<cards.count {
                    if checkSet(in: [cards[i], cards[j], cards[k]]) {
                        return [cards[i], cards[j], cards[k]]
                    }
                }
            }
        }
        return nil
    }
    
    
    mutating func checkSet(in cards: [Card]) -> Bool {
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
        cheat()
        if remainingSet != nil {
            score -= 3
        }
        turnOffCheat()
        
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
        print(playingCards.count)
        if numberOfPlayedCards == totalNumberOfCards {
            if getRemainingSet(in: playingCards) == nil {
                isEndOfGame = true
            }
        }
    }
    
    mutating func turnOffCheat() {
        if remainingSet != nil {
            for remainingIndex in 0..<2 {
                if let index = playingCards.firstIndex(of: remainingSet![remainingIndex]) {
                    playingCards[index].isHint = false
                }
            }
            remainingSet = nil
        }
    }
    
    mutating func cheat() {
        score -= 3
        var dupPlayingCards = playingCards
        if chosenCards.count == 3 {
            chosenCards.forEach { card in
                let matchedIndex = dupPlayingCards.firstIndex(of: card)!
                dupPlayingCards.remove(at: matchedIndex)
            }
            
        }
        
        if let remainingSet = getRemainingSet(in: dupPlayingCards) {
            self.remainingSet = remainingSet
            
            for index in 0..<2 {
                playingCards[playingCards.firstIndex(of: remainingSet[index])!].isHint = true
            }
            
        } else {
            self.remainingSet = nil
        }
    }
    
    init(initialNumberOfPlayingCards: Int, totalNumberOfCards: Int, createCardContent: @escaping (Int) -> Card.CardContent) {
        self.initialNumberOfPlayingCards = initialNumberOfPlayingCards
        self.totalNumberOfCards = totalNumberOfCards
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
        var isHint = false
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




