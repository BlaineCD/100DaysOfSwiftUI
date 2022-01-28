//
//  AddressView.swift
//  Project_10_CupcakeCorner
//
//  Created by Blaine Dannheisser on 1/27/22.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAdress)
                TextField("City", text: $order.city)
                TextField("Zip Code", text: $order.zip)
            }
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check Out")
                }
                .disabled(order.hasValidAddress == false)
            }
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        AddressView(order: Order())
        }
    }
}
