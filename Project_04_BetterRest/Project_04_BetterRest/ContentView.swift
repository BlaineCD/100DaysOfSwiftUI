//
//  ContentView.swift
//  Project_04_BetterRest
//
//  Created by Blaine Dannheisser on 12/20/21.
//

import CoreML
import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 30
        return Calendar.current.date(from: components) ?? Date.now
    }

    var body: some View {
        NavigationView {
            Form {
                Section("⏰ Wake Up Time ⏰") {
                    DatePicker("Please Enter A Wake Up Time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }.headerProminence(.increased)

                Section("💤 Sleep Amount 💤") {
                    Stepper("\(sleepAmount.formatted()) Hours", value: $sleepAmount, in: 3 ... 12, step: 0.25)
                }.headerProminence(.increased)

                Section("☕ Daily Coffee Intake ☕") {
                    Picker("Amount:", selection: $coffeeAmount) {
                        ForEach(1 ..< 21) {
                            $0 == 1 ? Text("\($0) Cup of Coffee") : Text("\($0) Cups of Coffee")
                        }
                    }
                }.headerProminence(.increased)

                Section("🛏️ Ideal Bedtime 🛏️") {
                    Text("\(calculateBedTime())")
                        .font(.title3.weight(.heavy))
                }.headerProminence(.increased)
            }
            .navigationTitle("BetterRezzzt")
            .toolbar {
                Button {
                    showingAlert = true
                } label: {
                    Image(systemName: "info.circle.fill")
                }
            }

            .alert("BetterRezzt", isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text("Visit HackingWithSwift for more information. Follow @ShuggieBlaine on Twitter to follow my progress.")
            }
        }
    }

    // MARK: Internal

    func calculateBedTime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep

            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "Error, Please Try Again"
        }
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
