//
//  CardView.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import SwiftUI

struct CardView: View {
    let card: SunSetGame.Card
    
    var body: some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: 10)
            if card.isMatched {
                cardShape.foregroundColor(.green).opacity(0.1)
                cardShape.strokeBorder(lineWidth:3).foregroundColor(.green)
                
            } else {
                cardShape.fill().foregroundColor(.white)
                cardShape.strokeBorder(lineWidth: 2)
                if card.isChosen {
                    cardShape.strokeBorder(lineWidth: 3).foregroundColor(.orange)
                }
                VStack {
                    ForEach(0..<card.symbol.numberOfShapes, id: \.self) { _ in
                        createSymbol(for: card)
                    }
                }
                .padding()
                
                if card.isNotMatched {
                    cardShape.foregroundColor(.gray).opacity(0.1)
                    cardShape.strokeBorder(lineWidth: 3).foregroundColor(.gray)
                }
                
                if card.isHint {
                    cardShape.foregroundColor(.green).opacity(0.2)
                    cardShape.strokeBorder(lineWidth: 3).foregroundColor(.green)
                }
            }
        }
    }
    
    @ViewBuilder
    func createSymbol(for card: SunSetGame.Card) -> some View {
        switch card.symbol.shape {
        case .roundedRectangle:
            createSymbolView(of: card.symbol, shape: RoundedRectangle(cornerRadius: 50))
        case .squiggle:
            createSymbolView(of: card.symbol, shape:
                                Squiggle())
        case .diamond:
            createSymbolView(of: card.symbol, shape: Diamond())
        }
    }
    
    @ViewBuilder
    private func createSymbolView<SymbolShape>(of symbol: SunSetGame.Card.CardContent, shape: SymbolShape) -> some View where SymbolShape: Shape {
        
        switch symbol.pattern {
        case .filled:
            shape.fill().foregroundColor(symbol.color.getColor())
                .aspectRatio(2/1, contentMode: .fit).opacity(0.7)
            
        case .shaded:
            StripeView(shape: shape, color: symbol.color.getColor())
                .aspectRatio(2/1, contentMode: .fit).opacity(0.7)
            
        case .stroked:
            shape.stroke(lineWidth: 2).foregroundColor(symbol.color.getColor())
                .aspectRatio(2/1, contentMode: .fit).opacity(0.7)
        }
    }
    
}

//
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        let
//        CardView()
//    }
//}
