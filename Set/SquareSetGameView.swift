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
            ScrollView {
                AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                    CardView(card: card)
                        .padding(5)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
                .padding(.horizontal)
                .foregroundColor(.blue)
            }
            HStack {
                Spacer()
                Button {
                } label: {
                    Text("New Game")
                }
                Spacer()
                Button {
                    game.dealThreeCards()
                } label: {
                    Text("Deal 3 Cards")
                }
                Spacer()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SquareSetGame()
        SquareSetGameView(game: game)
    }
}
