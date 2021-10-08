//
//  ContentView.swift
//  Set
//
//  Created by sun on 2021/10/07.
//

import SwiftUI

struct SquareSetGameView: View {
    @ObservedObject var game: SquareSetGame
    
    var body: some View {
        VStack {
            if game.isEndOfGame {
                Text("Game Over!")
                    .foregroundColor(.green).font(.largeTitle)
            }
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .padding(5)
                            .onTapGesture {
                                game.choose(card)
                            }
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            
            
            
        }
        .padding(.horizontal)
        .foregroundColor(.blue)
        //                AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
        //                    CardView(card: card)
        //                        .padding(5)
        //                        .onTapGesture {
        //                            game.choose(card)
        //                        }
        //                }
        //                .padding(.horizontal)
        //                .foregroundColor(.blue)
        HStack {
            Spacer()
            Button {
                game.newGame()
            } label: {
                Text("New Game")
            }
            Spacer()
            Button {
                game.dealThreeCards()
            } label: {
                if game.numberOfPlayedCards < game.totalNumberOfCards {
                    Text("Deal 3 Cards")
                }
                else {
                    Text("Deal 3 Cards").foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SquareSetGame()
        SquareSetGameView(game: game)
    }
}
