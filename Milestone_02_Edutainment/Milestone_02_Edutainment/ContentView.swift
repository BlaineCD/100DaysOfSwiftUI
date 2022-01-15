//
//  ContentView.swift
//  Milestone_02_Edutainment
//
//  Created by Blaine Dannheisser on 1/9/22.
//

import SwiftUI

// MARK: - GameMode

enum GameMode {
    case settings, play
}

// MARK: - Question

struct Question {
    var question: String
    var answer: Int
}

// MARK: - ContentView

struct ContentView: View {


    @State private var gameMode = GameMode.settings
    @State private var timesTables = 4

    var timesTableSelected: Int {
        let selection = Int(timesTables + 2)
        return selection
    }

    @State private var questions = [Question]()

    let numOfQuestions = [5, 10, 15, 20]
    @State private var numOfQuestionsSelected = 5
    @State private var questionNumber = 1
    @State private var numOfCorrect = 0
    @State private var numOfWrong = 0

    @State private var userAnswer = 1.0

    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    let correctTitle = ["Right", "Correct", "Bingo", "Ding Ding Ding", "Yes", "Genius"]
    let correctMessage = ["Keep up the good work!", "You're doing great!", "You're a multiplication wiz!", "You're a brainiac!", "✅"]
    let wrongTitle = ["Hmmm.. That's not right.", "❌", "Didn't quite get this one", "Wrong"]
    let wrongMessage = ["You didn't get this one, but keep at it!", "This is hard stuff, but you can get the next one right", "I'm sorry, you didn't solve this one"]

    @State private var endGame = false

    @State private var animationAmount = 0.0
    @State private var gradientAmount = 0.85

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(stops: [
                    Gradient.Stop(color: .white, location: 0.85),
                    Gradient.Stop(color: .blue, location: 0.99)
                ]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack {
                    if gameMode == GameMode.settings {
                        Text("Select Your Times Table")
                            .font(.title3.weight(.semibold))
                        Picker("Times Table", selection: $timesTables) {
                            ForEach(2 ..< 13) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.wheel)

                        Spacer()

                        Text("Select Number Of Questions")
                            .font(.title3.weight(.semibold))
                        Picker("Number of Questions", selection: $numOfQuestionsSelected) {
                            ForEach(numOfQuestions, id: \.self) {
                                Text($0, format: .number)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()

                        Spacer()

                        Button("Start Multiplying") {
                            generateQuestions()
                            withAnimation {
                                animationAmount += 360
                            }
                        }
                        .padding(EdgeInsets(top: 16, leading: 26, bottom: 16, trailing: 26))
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))

                        Spacer()

                    } else if gameMode == GameMode.play {

                        ZStack {
                            LinearGradient(gradient: Gradient(stops: [
                                Gradient.Stop(color: .white, location: gradientAmount),
                                Gradient.Stop(color: .blue, location: 0.95)
                            ]), startPoint: .top, endPoint: .bottom)
                                .ignoresSafeArea()

                            VStack {
                                Text("Question \(questionNumber) of \(numOfQuestionsSelected)")
                                    .font(.title3.weight(.semibold))
                                Text("\(questions[questionNumber].question)")
                                    .font(.title.weight(.heavy))

                                Spacer()
                                Spacer()

                                Text("\(Int(userAnswer))")
                                    .font(.title2.weight(.heavy))
                                Slider(value: $userAnswer, in: 0 ... 250, step: 1)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                                    .accentColor(Color.green)

                                Spacer()
                                Spacer()

                                Button {
                                    withAnimation {
                                        animationAmount += 360
                                    }
                                    calculate()
                                } label: {
                                    Text("Submit")
                                }
                                .padding(EdgeInsets(top: 16, leading: 60, bottom: 16, trailing: 60))
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))

                                Spacer()
                            }
                        }
                    }
                }
            }
            .navigationTitle("xTables")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if gameMode == GameMode.play {
                        Button {
                            gameMode = GameMode.settings
                        } label: {
                            Image(systemName: "arrowshape.turn.up.left.circle")
                        }
                    }
                }
            }

            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {
                    nextQuestion()
                }
            } message: {
                Text(alertMessage)
            }

            .alert("Game Over", isPresented: $endGame) {
                Button("OK") {
                   reset()
                }
            } message: {
                Text("You got \(numOfCorrect) out of \(numOfQuestionsSelected) correct!")
            }
        }
    }

    // MARK: Internal

    func generateQuestions() {
        gameMode = GameMode.play
        questionNumber = 1

        for i in 0 ... 20 {
            let question = Question(question: "\(timesTableSelected) x \(i)", answer: timesTableSelected * i)
            questions.append(question)
            questions.shuffle()
        }
    }

    func calculate() {
        if Int(userAnswer) == Int(questions[questionNumber].answer) {
            alertTitle = correctTitle.randomElement() ?? "Correct"
            alertMessage = correctMessage.randomElement() ?? "Nice Work!"
            numOfCorrect += 1
            animateBackgroundCorrect()
        } else {
            alertTitle = wrongTitle.randomElement() ?? "Wrong"
            alertMessage = wrongMessage.randomElement() ?? "You can do this!"
            numOfWrong += 1
            animateBackgroundWrong()
        }
        questionNumber += 1
        showingAlert = true
    }

    func nextQuestion() {
        if questionNumber > numOfQuestionsSelected {
            endGame = true
        }
    }

    func animateBackgroundCorrect() {
        switch numOfQuestionsSelected {
        case 5:
            gradientAmount -= 0.30
        case 10:
            gradientAmount -= 0.15
        case 15:
            gradientAmount -= 0.10
        case 20:
            gradientAmount -= 0.05
        default:
            print("ERROR")
        }
    }

    func animateBackgroundWrong() {
        switch numOfQuestionsSelected {
        case 5:
            gradientAmount += 0.14
        case 10:
            gradientAmount += 0.14
        case 15:
            gradientAmount += 0.14
        case 20:
            gradientAmount += 0.14
        default:
            print("ERROR")
        }
    }

    func reset() {
        gameMode = GameMode.settings
        gradientAmount = 0.85
        numOfCorrect = 0
        numOfWrong = 0
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
