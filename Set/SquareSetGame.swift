//
//  SquareSetGame.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import SwiftUI

class SquareSetGame: ObservableObject {
    typealias Card = SetGame<Shape, Color, Pattern, NumberOfShapes>.Card
    
    static let cardContents: [Card.CardContent] = {
        var contents = [Card.CardContent]()
        
        for shape in Shape.allCases {
            for color in Color.allCases {
                for pattern in Pattern.allCases {
                    for numberOfShapes in NumberOfShapes.allCases {
                        contents.append(Card.CardContent( shape: shape, color: color, pattern: pattern, numberOfShapes: numberOfShapes.rawValue))
                    }
                }
            }
        }
        return contents.shuffled()
    }()
    
    static private func createSetGame() -> SetGame<Shape, Color, Pattern, NumberOfShapes> {
        SetGame { cardContents[$0] }
    }
    
    
    @Published private var model = createSetGame()
    
    var cards: [Card] {
        model.playingCards
    }
    
    
    
    
    
    
    
    
    enum Shape: CaseIterable {
        case roundedRectangle
        case diamond
        case square
    }
    
    enum Color: CaseIterable {
        case red
        case green
        case purple
    }
    
    enum Pattern: CaseIterable {
        case filled
        case stroked
        case shaeded
    }
    
    enum NumberOfShapes: Int, CaseIterable {
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
