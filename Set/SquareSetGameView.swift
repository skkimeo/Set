//
//  ContentView.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import SwiftUI

struct SunSetGameView: View {
    @ObservedObject var game: SunSetGame
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Score: \(game.score)")
                    .bold().foregroundColor(.black).padding(.bottom)
                
                if !game.isEndOfGame {
                    AspectVGrid(items: game.playingCards, aspectRatio: 2/3) { card in
                        CardView(card: card)
                            .padding(5)
                            .onTapGesture {
//                                withAnimation(.easeInOut(duration: 4)) {
                                getPiledCards()
                                    game.choose(card)
//                                }
                            }
                    }
                } else {
                    Text("Game Over").foregroundColor(.green).font(.largeTitle)
                }
                
                HStack {
                    Spacer()
                    deckBody
                    Spacer()
                    discardPileBody
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    restart
                    Spacer()
                    if !game.isEndOfGame {
                        cheat
                        Spacer()
                    }
                }
                .padding(.bottom)
            }
            .padding()
            .foregroundColor(.blue)
            .navigationBarTitle("Sun-Set!")
        }
    }
    
    private func isUndealt(_ card: SunSetGame.Card) -> Bool {
        return !game.playingCards.contains(card) && !card.isMatched
    }
    
    private func zIndex(of card: SunSetGame.Card) -> Double {
        -Double(game.allCards.firstIndex(of: card) ?? 0)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.allCards.filter(isUndealt)) { card in
                CardView(card: card)
                    .zIndex(zIndex(of: card))
            }
            RoundedRectangle(cornerRadius: 10).foregroundColor(.blue)
        }
        .frame(width: 60, height: 90)
        .onTapGesture {
            getPiledCards()
            game.dealThreeCards()
        }
    }
    
    @State var matchedCards = [SunSetGame.Card]()

    private func getPiledCards() {
        for card in game.allCards.filter({ $0.isMatched }) {
            var dup = card
            dup.isMatched = false
            if !matchedCards.contains(dup) {
                matchedCards.append(dup)
            }
        }
//        return matchedCards
    }
//    @State var matched = [s]
//    var matchedCards: [SunSetGame.Card] {
//        var cards = [SunSetGame.Card]()
//        for card in game.allCards.filter({ $0.isMatched }) {
//            var dup = card
//            dup.isMatched = false
//            cards.append(dup)
//        }
//        return cards
//    }
    
    var discardPileBody: some View {
        return ZStack {
            Color.clear
            ForEach(matchedCards) { card in
                CardView(card: card)
            }
        }
        .frame(width: 60, height: 90)
    }
    
    var restart: some View {
        Button("Restart") { game.newGame() }
    }
    
    var cheat: some View {
        Button("Cheat") { game.cheat() }
    }
    
}













struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SunSetGame()
        SunSetGameView(game: game)
    }
}
