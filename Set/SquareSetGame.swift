//
//  SquareSetGame.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import SwiftUI

class SquareSetGame: ObservableObject {
    typealias Card = SetGame<ContentShape, ContentColor, ContentPattern, NumberOfContentShapes>.Card
    
    static var cardContents: [Card.CardContent] = {
        var contents = [Card.CardContent]()
        
//        SMALL DECK OF CARDS
        for shape in ContentShape.allCases {
            for color in ContentColor.allCases {
                for number in NumberOfContentShapes.allCases {
                    contents.append(Card.CardContent(shape: shape, color: color, pattern: .shaded, numberOfShapes: number.rawValue))
                }
            }
        }
        
//        for shape in ContentShape.allCases {
//            for color in ContentColor.allCases {
//                for pattern in ContentPattern.allCases {
//                    for numberOfShapes in NumberOfContentShapes.allCases {
//                        contents.append(Card.CardContent( shape: shape, color: color, pattern: pattern, numberOfShapes: numberOfShapes.rawValue))
//                    }
//                }
//            }
//        }
        
        return contents.shuffled()
    }()
    
    static private func createSetGame() -> SetGame<ContentShape, ContentColor, ContentPattern, NumberOfContentShapes> {
        return SetGame { cardContents[$0] }
    }
    
    
    @Published private var model = createSetGame()
    
    var cards: [Card] {
        model.playingCards
    }
    
    var numberOfPlayedCards: Int {
        model.numberOfPlayedCards
    }
    
    var totalNumberOfCards: Int {
        model.totalNumberOfCards
    }
    
    var isEndOfGame: Bool {
        model.isEndOfGame
    }
    
    // MARK: -Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func dealThreeCards() {
        model.dealThreeCards()
    }
    
    func newGame() {
        SquareSetGame.cardContents.shuffle()
        model = SquareSetGame.createSetGame()
        
    }
    
    
    enum ContentShape: CaseIterable {
        case roundedRectangle
        case diamond
        case square
        
        @ViewBuilder
        func getShape() -> some View {
            switch self {
            case .roundedRectangle:
                RoundedRectangle(cornerRadius: 50)
            case .diamond:
                Circle()
            case .square:
                RoundedRectangle(cornerRadius: 0)
            }
        }
    }
    
    enum ContentColor: CaseIterable {
        case red
        case green
        case purple
        
        func getColor() -> Color {
            switch self {
            case .red:
                return Color.red
            case .green:
                return Color.green
            case .purple:
                return Color.purple
            }
        }
    }
    
    enum ContentPattern: CaseIterable {
        case filled
        case stroked
        case shaded
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
