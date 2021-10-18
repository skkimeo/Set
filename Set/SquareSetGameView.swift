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
                    AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                        CardView(card: card)
                            .padding(5)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                } else {
                    Text("Game Over").foregroundColor(.green).font(.largeTitle)
                }
                
                HStack {
                    Spacer()
                    restart
                    Spacer()
                    if !game.isEndOfGame {
                        cheat
                        Spacer()
                        if game.numberOfPlayedCards < game.totalNumberOfCards {
                            deal3Cards
                        } else {
                            Text("Deal 3 Cards").foregroundColor(.gray)
                        }
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
    
    var restart: some View {
        Button("Restart") { game.newGame() }
    }
    
    var cheat: some View {
        Button("Cheat") { game.cheat() }
    }
    
    var deal3Cards: some View {
        Button("Deal 3 Cards") { game.dealThreeCards() }
    }
}













struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SunSetGame()
        SunSetGameView(game: game)
    }
}
