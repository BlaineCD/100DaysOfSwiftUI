//
//  ContentView.swift
//  Project_10_CupcakeCorner
//
//  Created by Blaine Dannheisser on 1/26/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var orderClass = OrderClass()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Pick Your Cake Flavor:", selection: $orderClass.order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of Cakes: \(orderClass.order.quantity)",
                            value: $orderClass.order.quantity,
                            in: 3...20)
                }
                Section {
                    Toggle("Any Special Requests?",
                           isOn: $orderClass.order.specialRequestEnabled.animation())

                    if orderClass.order.specialRequestEnabled {
                        Toggle("Add Extra Frosting",
                               isOn: $orderClass.order.extraFrosting)
                        Toggle("Add Extra Sprinkles",
                               isOn: $orderClass.order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink {
                        AddressView(orderClass: orderClass)
                    } label: {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationTitle("🧁 Cupcake Corner 🧁")
        }
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

