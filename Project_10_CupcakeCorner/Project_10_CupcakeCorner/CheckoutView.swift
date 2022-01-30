//
//  CheckoutView.swift
//  Project_10_CupcakeCorner
//
//  Created by Blaine Dannheisser on 1/27/22.
//

import SwiftUI

// MARK: - CheckoutView

struct CheckoutView: View {
    @ObservedObject var order: Order

    @State private var showingConfirmation = false
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(confirmationTitle, isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
    }

    // MARK: Internal

    func placeOrder() async {
        // convert order object to JSON Data
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        // how to send the data
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //HTTP method: GET (read data) and POST (write data)
        request.httpMethod = "POST"

        // make network request
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            // run the request and process the reposnse
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationTitle = "Thank you! Your order confirmation number is \(UUID())"
            confirmationMessage = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcakes is on the way!"
            showingConfirmation = true
        } catch {
            //Challenge 2
            confirmationTitle = "Uh Oh"
            confirmationMessage = "Please check your connection and try again"
            showingConfirmation = true
        }
    }
}

// MARK: - CheckoutView_Previews

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(order: Order())
        }
    }
}
