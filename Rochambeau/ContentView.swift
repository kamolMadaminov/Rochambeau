//
//  ContentView.swift
//  Rochambeau
//
//  Created by Kamol Madaminov on 24/03/25.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    
    @State private var appMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var round = 1
    @State private var showingScore = false
    @State private var gameOver = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Round \(round) / 10")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Text("App chose: \(moves[appMove])")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)

                Text(shouldWin ? "You must WIN" : "You must LOSE")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.yellow)

                HStack {
                    ForEach(0..<3) { index in
                        Button(action: {
                            playGame(playerMove: index)
                        }) {
                            Text(moves[index])
                                .foregroundStyle(.white)
                                .font(.system(size: 30))
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                }
                
                Text("Score: \(score)")
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
            }
            .padding()
        }
        .alert("Round Over", isPresented: $showingScore) {
            Button("Next Round", action: nextRound)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Final score: \(score) / 10")
        }
    }
    
    func playGame(playerMove: Int) {
        let winningMoves = [1, 2, 0]
        let losingMoves = [2, 0, 1]

        let correctMove = shouldWin ? winningMoves[appMove] : losingMoves[appMove]

        if playerMove == correctMove {
            score += 1
        } else {
            score -= 1
        }

        if round == 10 {
            gameOver = true
        } else {
            showingScore = true
        }
    }
    
    func nextRound() {
        appMove = Int.random(in: 0...2)
        shouldWin.toggle()
        round += 1
    }

    func resetGame() {
        score = 0
        round = 1
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
