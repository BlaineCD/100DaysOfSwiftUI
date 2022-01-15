//
//  ContentView.swift
//  Project_05_WordScramble
//
//  Created by Blaine Dannheisser on 12/27/21.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter New Word", text: $newWord)
                        .autocapitalization(.none)
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).square")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Score: \(score)")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        restart()
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                    }
                }
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)

            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
    }

    // MARK: Internal

    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !answer.isEmpty else { return }

        guard isOriginal(word: answer) else {
            wordError(title: "Word Used Already", message: "Be More Original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word Not Possible", message: "You Can't Spell That Word From \(rootWord)!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word Not Recognized", message: "Are Can't Invent New Words")
            return
        }

        guard isTooShort(word: answer) else {
            wordError(title: "Word Too Short", message: "Word Must Be At Least Three Letters")
            return
        }

        guard isSameWord(word: answer) else {
            wordError(title: "Word Is The Same", message: "You Must Find A New Word")
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }

        score += answer.count

        newWord = ""
    }

    // Word Validation Methods
    // Validation (1)
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    // Validation (2)
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }

    // Validation (3)
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    // Validation (4) Challenge
    func isTooShort(word: String) -> Bool {
        word.count > 2
    }

    func isSameWord(word: String) -> Bool {
        word != rootWord
    }

    // Show Alert
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

    func restart() {
        usedWords = []
        newWord = ""
        score = 0
        startGame()
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
