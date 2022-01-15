//
//  ExpenseItem.swift
//  Project_07_iExpense
//
//  Created by Blaine Dannheisser on 1/13/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let date: Date
}

/*
 add Identifiable to the list of protocol conformances. This is one of the protocols built into Swift, and means “this type can be identified uniquely.” It has only one requirement, which is that there must be a property called id that contains a unique identifier.
 
 Now, you might wonder why we added that, because our code was working fine before. Well, because our expense items are now guaranteed to be identifiable uniquely, we no longer need to tell ForEach which property to use for the identifier – it knows there will be an id property and that it will be unique, because that’s the point of the Identifiable protocol.
 */
