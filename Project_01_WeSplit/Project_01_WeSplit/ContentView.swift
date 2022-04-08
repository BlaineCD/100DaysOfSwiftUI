//
//  ContentView.swift
//  Project_01_WeSplit
//
//  Created by Blaine Dannheisser on 11/28/21.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    let tipPercentages = [0, 10, 15, 20, 25]

    let localCurrencyFormatter: FloatingPointFormatStyle<Double>.Currency =  .currency(code: Locale.current.currencyCode ?? "USD")

    var tipTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return tipValue
    }

    var totalPlusTip: Double {
        let grandTotal = checkAmount + tipTotal
        return grandTotal
    }

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 1)
        let amountPerPerson = totalPlusTip / peopleCount
        return amountPerPerson
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check Amount", value: $checkAmount, format: localCurrencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                    Picker("Number Of Diners", selection: $numberOfPeople) {
                        ForEach(1 ..< 100) {
                            Text("\($0) Diners")
                        }
                    }
                }

                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip Selection: $\(tipTotal, specifier: "%.2f")")
                }

                Section("Grand Total:") {
                    Text(totalPlusTip, format: localCurrencyFormatter)
                }

                Section("Total Per Diner:") {
                    Text(totalPerPerson, format: localCurrencyFormatter)
                }
            }
            .navigationTitle("WeSplit")
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
