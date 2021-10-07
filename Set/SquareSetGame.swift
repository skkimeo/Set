//
//  SquareSetGame.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import SwiftUI

class SquareSetGame: ObservableObject {
    typealias Card = SetGame<ContentShape, ContentColor, ContentPattern, NumberOfContentShapes>.Card
    
    static let cardContents: [Card.CardContent] = {
        var contents = [Card.CardContent]()
        
        for shape in ContentShape.allCases {
            for color in ContentColor.allCases {
                for pattern in ContentPattern.allCases {
                    for numberOfShapes in NumberOfContentShapes.allCases {
                        contents.append(Card.CardContent( shape: shape, color: color, pattern: pattern, numberOfShapes: numberOfShapes.rawValue))
                    }
                }
            }
        }
        return contents.shuffled()
    }()
    
    static private func createSetGame() -> SetGame<ContentShape, ContentColor, ContentPattern, NumberOfContentShapes> {
        SetGame { cardContents[$0] }
    }
    
    
    @Published private var model = createSetGame()
    
    var cards: [Card] {
        model.playingCards
    }
    
    // MARK: -Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func dealThreeCards() {
        model.deal_three_cards()
    }
    
    func newGame() {
        
    }
    
    
    enum ContentShape: CaseIterable {
        case roundedRectangle
        case diamond
        case square
    }
    
    enum ContentColor: CaseIterable {
        case red
        case green
        case purple
    }
    
    enum ContentPattern: CaseIterable {
        case filled
        case stroked
        case shaeded
    }
    
    enum NumberOfContentShapes: Int, CaseIterable {
        case one = 1
        case two
        case three
    }
    
//    struct CardContent {
//        let shape: Shape
//        let color: Color
//        let pattern: Pattern
//        let numberOfShapes: NumberOfShapes
//    }
}
