//
//  ContentView.swift
//  MIlestone_01_RockPaperScissors
//
//  Created by Blaine Dannheisser on 12/8/21.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    @State private var userScore = 0
    @State private var questionNumber = 0
    @State private var gameOverAlert = false

    @State private var rockPaperScissor = ["rock", "paper", "scissor"]
    @State private var computerSelection = Int.random(in: 0 ..< 3)

    let instructions = ["Winning", "Losing"]
    @State private var winLose = Int.random(in: 0 ..< 2)

    @State private var instructionTextColor = true

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color("top"), location: 0.5),
                .init(color: Color("bottom"), location: 0.5)
            ],
            center: .top, startRadius: 200, endRadius: 600)
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("Question: \(questionNumber) of 10")
                    Text("Score: \(userScore)")
                }
                .font(.headline.weight(.regular))

                Spacer()

                Image(rockPaperScissor[computerSelection])
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                    .shadow(radius: 7)

                Spacer(minLength: 140)

                Text("Select The \(instructions[winLose]) Move!")
                    .padding(20)
                    .font(.title2.weight(.heavy))
                    .foregroundColor(instructions[winLose] == "Winning" ? Color("win") : Color("lose"))
                    .shadow(color: .gray, radius: 0.6)

                HStack(spacing: 40) {
                    ForEach(0 ..< rockPaperScissor.count) { number in
                        Button {
                            buttonTapped(number)
                        } label: {
                            Image(rockPaperScissor[number])
                                .resizable()
                                .padding(10)
                                .frame(width: 75,
                                       height: 75,
                                       alignment: .center)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }

                .alert("Game Over", isPresented: $gameOverAlert) {
                    Button("Play Again") {
                        newGame()
                    }
                } message: {
                    Text("Your final score: \(userScore)")
                }

                Spacer(minLength: 180)
            }
        }
    }

    // MARK: Internal

    func buttonTapped(_ number: Int) {
        let user = rockPaperScissor[number]
        let computer = rockPaperScissor[computerSelection]
        let instruction = instructions[winLose]

        if computer == "rock", instruction == "Winning" {
            switch user {
            case "paper":
                userScore += 1
            case "scissor":
                userScore -= 1
            default:
                print("It's a tie")
            }
        } else if computer == "rock", instruction == "Losing" {
            switch user {
            case "paper":
                userScore -= 1
            case "scissor":
                userScore += 1
            default:
                print("It's a tie")
            }
        } else if computer == "paper", instruction == "Winning" {
            switch user {
            case "scissor":
                userScore += 1
            case "rock":
                userScore -= 1
            default:
                print("It's a tie")
            }
        } else if computer == "paper", instruction == "Losing" {
            switch user {
            case "scissor":
                userScore -= 1
            case "rock":
                userScore += 1
            default:
                print("What did you do?!?")
            }
        } else if computer == "scissor", instruction == "Winning" {
            switch user {
            case "rock":
                userScore += 1
            case "paper":
                userScore -= 1
            default:
                print("It's a tie")
            }
        } else if computer == "scissor", instruction == "Losing" {
            switch user {
            case "rock":
                userScore -= 1
            case "paper":
                userScore += 1
            default:
                print("It's a tie")
            }
        }
        questionCount()
        winOrLose()
        computerThrows()
    }

    func winOrLose() {
        winLose = Int.random(in: 0 ..< 2)
    }

    func computerThrows() {
        rockPaperScissor.shuffle()
        computerSelection = Int.random(in: 0 ..< 3)
    }

    func questionCount() {
        questionNumber += 1

        if questionNumber >= 10 {
            gameOverAlert = true
        }
    }

    func newGame() {
        questionNumber = 0
        userScore = 0
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
