//
//  ContentView.swift
//  Milestone_06_RollTheDice
//
//  Created by Blaine Dannheisser on 4/5/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showSettings = false
    @State private var showDiceTypeSelection = false
    @State private var showNumberOfDiceSelection = false

    @AppStorage("selectedDiceType") var selectedDiceType = 6
    @AppStorage("numberToRoll") var numberToRoll = 2

    @State private var currentRoll = Dice(type: 0, number: 0)

    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var stoppedDice = 0

    @State private var feedback = UIImpactFeedbackGenerator(style: .rigid)

    let columns: [GridItem] = [
        .init(.adaptive(minimum: 40))
    ]

    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedRolls.json")

    @State private var savedResults = [Dice]()

    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(0..<currentRoll.rolls.count, id: \.self) { rollNum in
                        Text(String(currentRoll.rolls[rollNum]))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .foregroundColor(.black)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .font(.title)
                            .padding(5)
                    }
                }
                .padding()

                Spacer()

                HStack {
                    Button {
                        showDiceTypeSelection.toggle()
                    } label: {
                        Image(systemName: "dice")
                            .foregroundColor(.white)
                            .padding()
                            .background(.orange)
                            .clipShape(Circle())
                            .shadow(color: .black, radius: 3.0, x: -0.7, y: 1.0)
                    }

                    Spacer()

                    Button {
                        rollDice()
                    } label: {
                        Text("Roll Dice!")
                            .foregroundColor(.white)
                            .padding()
                            .background(.red)
                            .clipShape(Capsule())
                            .shadow(color: .black, radius: 3.0, x: 0.7, y: 1.0)
                    }
                    .disabled(stoppedDice < currentRoll.rolls.count)

                    Spacer()

                    Button {
                        showNumberOfDiceSelection.toggle()
                    } label: {
                        Image(systemName: "slider.vertical.3")
                            .foregroundColor(.white)
                            .padding()
                            .background(.orange)
                            .clipShape(Circle())
                            .shadow(color: .black, radius: 3.0, x: 0.7, y: 1.0)
                    }
                }

                .padding()

                if savedResults.isEmpty == false {
                    List {
                        Section("Roll History") {
                            ForEach(savedResults) { result in
                                VStack(alignment: .leading) {
                                    Text("\(result.number) x \(result.type)")
                                        .font(.headline)
                                    Text(result.rolls.map(String.init).joined(separator: ", "))
                                }
                            }
                        }
                    }
                }
            }


            .onAppear(perform: load)

            .onReceive(timer) { date in
                updateDice()
            }

            .confirmationDialog("Select dice type:", isPresented: $showDiceTypeSelection) {
                Button("4 Sided") { selectedDiceType = 4 }
                Button("6 Sided") { selectedDiceType = 6 }
                Button("8 Sided") { selectedDiceType = 8 }
                Button("10 Sided") { selectedDiceType = 10 }
                Button("12 Sided") { selectedDiceType = 12 }
                Button("20 Sided") { selectedDiceType = 20 }
                Button("100 Sided") { selectedDiceType = 100 }
                Button("Cancel", role: .cancel) {}
            }

            .confirmationDialog("Select number of dice rolled", isPresented: $showNumberOfDiceSelection) {
                Button("1 Dice") { numberToRoll = 1 }
                Button("2 Dice") { numberToRoll = 2 }
                Button("4 Dice") { numberToRoll = 4 }
                Button("6 Dice") { numberToRoll = 6 }
                Button("8 Dice") { numberToRoll = 8 }
                Button("10 Dice") { numberToRoll = 10 }
                Button("12 Dice") { numberToRoll = 12 }
                Button("Cancel", role: .cancel) {}
            }
        }
    }

    func rollDice() {
        currentRoll = Dice(type: selectedDiceType, number: numberToRoll)
        stoppedDice = -20
    }

    func updateDice() {
        guard stoppedDice < currentRoll.rolls.count else { return }

        for i in stoppedDice..<numberToRoll {
            if i < 0 { continue }
            currentRoll.rolls[i] = Int.random(in: 1...selectedDiceType)
            feedback.impactOccurred()
        }
        stoppedDice += 1

        if stoppedDice == numberToRoll {
            savedResults.insert(currentRoll, at: 0)
            save()
        }
    }

    func load() {
        if let data = try? Data(contentsOf: savePath) {
            if let results = try? JSONDecoder().decode([Dice].self, from: data) {
                savedResults = results
            }
        }
    }

    func save() {
        if let data = try? JSONEncoder().encode(savedResults) {
            try? data.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
