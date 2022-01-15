//
//  ContentView.swift
//  Challenge_01
//
//  Created by Blaine Dannheisser on 11/30/21.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    @State private var inputSelection = 0
    let inputSelections = ["Meter", "Kilometer", "Yard", "Mile"]

    @State private var outputSelection = 2
    let outputSelections = ["Meter", "Kilometer", "Yard", "Mile"]

    @State private var inputNumber = ""
    @State private var outputNumber = ""

    @FocusState private var amountIsFocused: Bool

    var convertedInput: Double {
        let inputUnit = inputSelections[inputSelection]
        var inputNumber = Double(inputNumber) ?? 0

        if inputUnit == "Kilometer" {
            inputNumber = inputNumber * 1000
        } else if inputUnit == "Yard" {
            inputNumber = inputNumber / 1.094
        } else if inputUnit == "Mile" {
            inputNumber = inputNumber * 1609
        }
        return inputNumber
    }

    var convertedOutput: Double {
        let outputUnit = outputSelections[outputSelection]
        var outputNumber = Double(outputNumber) ?? 0

        if outputUnit == "Meter" {
            outputNumber = convertedInput
        } else if outputUnit == "Kilometer" {
            outputNumber = convertedInput / 1000
        } else if outputUnit == "Yard" {
            outputNumber = convertedInput * 1.094
        } else if outputUnit == "Mile" {
            outputNumber = convertedInput / 1609
        }
        return outputNumber
    }

    var body: some View {
        NavigationView {
            Form {
                Section("Select Length to Convert From:") {
                    Picker("Select Length for Input", selection: $inputSelection) {
                        ForEach(0 ..< inputSelections.count) {
                            Text("\(self.inputSelections[$0])")
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Input Length") {
                    TextField("Enter Length", text: $inputNumber)
                        .keyboardType(.numberPad)
                        .focused($amountIsFocused)
                }

                Section("Select Length to Convert To:") {
                    Picker("Select Length for Output", selection: $outputSelection) {
                        ForEach(0 ..< outputSelections.count) {
                            Text("\(self.outputSelections[$0])")
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Converted Length") {
                    Text("\(convertedOutput, format: .number)")
                }
            }
            .navigationTitle("Conversion App")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
