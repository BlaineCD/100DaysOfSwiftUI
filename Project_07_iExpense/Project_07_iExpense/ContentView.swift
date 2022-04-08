//
//  ContentView.swift
//  Project_07_iExpense
//
//  Created by Blaine Dannheisser on 1/12/22.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Expenses: Personal") {
                    ForEach(expenses.items.filter({ $0.type == "Personal"})) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .fontWeight(.bold)
                                Text("\(item.date, format: Date.FormatStyle().day().month().year())")
                            }
                            Spacer()
                            Text("\(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))")

                        }
                        .foregroundColor(item.amount < 10.00 ? .green : item.amount < 100 ? .orange : .red)
                    }
                    .onDelete(perform: removeRows)
                }
                Section("Expenses: Personal") {
                    ForEach(expenses.items.filter({ $0.type == "Business"})) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .fontWeight(.bold)
                                Text("\(item.date, format: Date.FormatStyle().day().month().year())")
                            }
                            Spacer()
                            Text("\(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))")

                        }
                        .foregroundColor(item.amount < 10.00 ? .green : item.amount < 100 ? .orange : .red)
                    }
                    .onDelete(perform: removeRows)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense.toggle()
                } label: {
                    Label("Add Expense", systemImage: "dollarsign.circle")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    // MARK: Internal
    
    func removeRows(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
