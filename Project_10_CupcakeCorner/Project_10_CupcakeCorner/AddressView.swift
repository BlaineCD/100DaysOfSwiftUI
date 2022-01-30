//
//  AddressView.swift
//  Project_10_CupcakeCorner
//
//  Created by Blaine Dannheisser on 1/27/22.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderClass: OrderClass

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderClass.order.name)
                TextField("Street Address", text: $orderClass.order.streetAddress)
                TextField("City", text: $orderClass.order.city)
                TextField("Zip Code", text: $orderClass.order.zip)
            }
            Section {
                NavigationLink {
                    CheckoutView(orderClass: orderClass)
                } label: {
                    Text("Check Out")
                }
                .disabled(orderClass.order.hasValidAddress == false)
            }
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        AddressView(orderClass: OrderClass())
        }
    }
}

