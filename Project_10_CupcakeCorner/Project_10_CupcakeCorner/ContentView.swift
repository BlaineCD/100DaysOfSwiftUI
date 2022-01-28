//
//  ContentView.swift
//  Project_10_CupcakeCorner
//
//  Created by Blaine Dannheisser on 1/26/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Pick Your Cake Flavor:", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of Cakes: \(order.quantity)",
                            value: $order.quantity,
                            in: 3...20)
                }
                Section {
                    Toggle("Any Special Requests?",
                           isOn: $order.specialRequestEnabled.animation())

                    if order.specialRequestEnabled {
                        Toggle("Add Extra Frosting",
                               isOn: $order.extraFrosting)
                        Toggle("Add Extra Sprinkles",
                               isOn: $order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
