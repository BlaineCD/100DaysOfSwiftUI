//
//  ContentView.swift
//  Project_02_GuessTheFlag
//
//  Created by Blaine Dannheisser on 12/4/21.
//

import SwiftUI

// MARK: - AnswerStatus

enum AnswerStatus {
    case unanswered, correct, wrong
}

// MARK: - ContentView

struct ContentView: View {

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    @State private var correctAnswer = Int.random(in: 0 ... 2)
    @State private var isShowingScore = false
    @State private var isGameOver = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var userScore = 0
    @State private var questionsAsked = 0

    @State private var animationAmount = 1.0
    @State private var tappedNum = 0
    @State private var answerStatus = AnswerStatus.unanswered

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap The Flag of...")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.primary)
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0 ..< 3) { number in
                        Button {
                            withAnimation {
                                flagTapped(number)
                            }
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                .opacity(answerStatus != AnswerStatus.unanswered && tappedNum != number ? 0.25 : 1.0)
                                .rotation3DEffect(.degrees(answerStatus == AnswerStatus.correct && tappedNum == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .scaleEffect(answerStatus == AnswerStatus.wrong && tappedNum == number ? animationAmount : 1)
                                .opacity(answerStatus != AnswerStatus.unanswered && tappedNum != number ? 0.25 : 1.0)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $isShowingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Game Over", isPresented: $isGameOver) {
            Button("Play Again", action: restart)
        } message: {
            Text("Your final score: \(userScore). Would you like to play again?")
        }
    }

    // MARK: Internal

    func flagTapped(_ number: Int) {
        tappedNum = number
        questionsAsked += 1

        if number == correctAnswer, questionsAsked < 8 {
            answerStatus = AnswerStatus.correct
            scoreTitle = "👏 Correct 👏"
            scoreMessage = "You selected the correct flag!"
            userScore += 1
            isShowingScore = true
        } else if number != correctAnswer, questionsAsked < 8 {
            answerStatus = AnswerStatus.wrong
            animationAmount -= 1
            scoreTitle = "👎 Wrong 👎"
            scoreMessage = "That's the flag of \(countries[number]). Score: \(userScore)"
            userScore -= 1
            isShowingScore = true
        } else {
            userScore += 1
            isGameOver = true
        }
    }

    func askQuestion() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0 ... 2)
            answerStatus = AnswerStatus.unanswered
            animationAmount = 1.0
    }

    func restart() {
        questionsAsked = 0
        askQuestion()
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
