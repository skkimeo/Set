//
//  CardView.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import SwiftUI

struct CardView: View {
    let card: SquareSetGame.Card
    
    var body: some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: 10)
            if card.isMatched {
                cardShape.opacity(0)
                
            } else {
                cardShape.fill().foregroundColor(.white)
                cardShape.strokeBorder(lineWidth: 2)
                if card.isChosen {
                    cardShape.strokeBorder(lineWidth: 3).foregroundColor(.orange)
                }
                //                GeometryReader { geometry in
                VStack {
                    switch card.content.numberOfShapes {
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
                }
                .padding(.horizontal)
                //                    }
                //                }
            }
            
        }
        
    }
    
    @ViewBuilder
    func createSymbol(for card: SquareSetGame.Card) -> some View {
        switch card.content.shape {
        case .roundedRectangle:
            createRoundedRectangleView(by: card.content)
        case .square:
            createSquareView(by: card.content)
        case .diamond:
            createDiamondView(by: card.content)
            
        }
    }
    
    @ViewBuilder
    private func createRoundedRectangleView(by symbol: SquareSetGame.Card.CardContent) -> some View {
        
        let symbolShape = RoundedRectangle(cornerRadius: 60)

        switch symbol.pattern {
        case .filled:
            symbolShape.fill().foregroundColor(symbol.color.getColor())
                .aspectRatio(2/1, contentMode: .fit)
        case .shaded:
            symbolShape.fill().foregroundColor(symbol.color.getColor()).opacity(0.5)
                .aspectRatio(2/1, contentMode: .fit)
        case .stroked:
            symbolShape.strokeBorder(lineWidth: 2.5).foregroundColor(symbol.color.getColor())
                .aspectRatio(2/1, contentMode: .fit)
        }
    }
    
    
    @ViewBuilder
    private func createDiamondView(by symbol: SquareSetGame.Card.CardContent) -> some View {
        
        let symbolShape = Diamond()
        switch symbol.pattern {
        case .filled:
            symbolShape.fill().foregroundColor(symbol.color.getColor())
                .aspectRatio(2/1, contentMode: .fit)
        case .shaded:
            ZStack {
                symbolShape.fill().foregroundColor(symbol.color.getColor())
                    .opacity(0.5).aspectRatio(2/1, contentMode: .fit)
//                symbolShape.stroke(lineWidth: 2).foregroundColor(symbol.color.getColor()).opacity(0.5).aspectRatio(2/1, contentMode: .fit)
            }
        case .stroked:
            symbolShape.stroke(lineWidth: 2.5).foregroundColor(symbol.color.getColor()).aspectRatio(2/1, contentMode: .fit)
        }
    }

    @ViewBuilder
    private func createSquareView(by symbol: SquareSetGame.Card.CardContent) -> some View {
        
        let symbolShape = RoundedRectangle(cornerRadius: 3)

        switch symbol.pattern {
        case .filled:
            symbolShape.fill().foregroundColor(symbol.color.getColor())
                .aspectRatio(2/1, contentMode: .fit)
        case .shaded:
            symbolShape.fill().foregroundColor(symbol.color.getColor()).opacity(0.5)
                .aspectRatio(2/1, contentMode: .fit)
        case .stroked:
            symbolShape.strokeBorder(lineWidth: 2.5).foregroundColor(symbol.color.getColor())
                .aspectRatio(2/1, contentMode: .fit)
        }
    }

    
}
//
//
//let filledRoundedRect = RoundedRectangle(cornerRadius: 50)
//filledRoundedRect
//    .fill()
//    .foregroundColor(.purple)
//    .aspectRatio(2/1, contentMode: .fit)
////                                .font(Font.system(size: min(geometry.size.height, geometry.size.width) ))
//
//let strokeRoundedRect = RoundedRectangle(cornerRadius: 50)
//strokeRoundedRect
//    .strokeBorder(lineWidth: 2.5)
//    .foregroundColor(.purple)
//    .aspectRatio(2/1, contentMode: .fit)
//
//let opacityRoundedRext = RoundedRectangle(cornerRadius: 50)
//opacityRoundedRext
//    .fill()
//    .foregroundColor(.purple)
//    .opacity(0.5)
//    .aspectRatio(2/1, contentMode: .fit)
//
//
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        let
//        CardView()
//    }
//}
