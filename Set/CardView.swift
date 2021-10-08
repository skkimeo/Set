//
//  CardView.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import SwiftUI

struct CardView: View {
    let card: SquareSetGame.Card
//    let isEndOfGame: Boo
    
    var body: some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: 10)
            if card.isMatched {
                cardShape.foregroundColor(.green).opacity(0.1)
                cardShape.strokeBorder(lineWidth:3).foregroundColor(.green)
//                if
                
            } else {
                cardShape.fill().foregroundColor(.white)
                cardShape.strokeBorder(lineWidth: 2)
                if card.isChosen {
                    cardShape.strokeBorder(lineWidth: 3).foregroundColor(.orange)
                }
                //                GeometryReader { geometry in
                HStack {
//                    Spacer()
                    switch card.symbol.numberOfShapes {
                    case 1: // change case to .one
                        createSymbol(for: card)
                    case 2:
                        createSymbol(for: card)
                        createSymbol(for: card)
                    case 3:
                        createSymbol(for: card)
                        createSymbol(for: card)
                        createSymbol(for: card)
                    default:
                        createSymbol(for: card)
                    }
//                    Spacer()
                }
//                .padding()
                .padding(8)
                
                if card.isNotMatched {
                    cardShape.foregroundColor(.gray).opacity(0.1)
                    cardShape.strokeBorder(lineWidth: 3).foregroundColor(.gray)
                }
                //                    }
                //                }
            }
            
        }
        
    }

    @ViewBuilder
    func createSymbol(for card: SquareSetGame.Card) -> some View {
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
    private func createSymbolView<SymbolShape>(of symbol: SquareSetGame.Card.CardContent, shape: SymbolShape) -> some View where SymbolShape: Shape {

        switch symbol.pattern {
        case .filled:
            shape.fill().foregroundColor(symbol.color.getColor())
                .aspectRatio(1/2, contentMode: .fit)
            
        case .shaded:
            StripeView(shape: shape, color: symbol.color.getColor())
                .aspectRatio(1/2, contentMode: .fit)
            
        case .stroked:
            shape.stroke(lineWidth: 2).foregroundColor(symbol.color.getColor())
                .aspectRatio(1/2, contentMode: .fit)
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
