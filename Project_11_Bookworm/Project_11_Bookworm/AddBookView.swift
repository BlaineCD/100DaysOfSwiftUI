//
//  AddBookView.swift
//  Project_11_Bookworm
//
//  Created by Blaine Dannheisser on 1/31/22.
//

import SwiftUI

// MARK: - AddBookView

struct AddBookView: View {

    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    @State private var date = Date()

    // Challenge 1:
    var hasValidEntry: Bool {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        Form {
            Section {
                TextField("Name of Book", text: $title)
                TextField("Author", text: $author)

                Picker("Genre", selection: $genre) {
                    ForEach(genres, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
            }

            Section {
                TextEditor(text: $review)

                RatingView(rating: $rating)

            } header: {
                Text("Write A Review:")
            }

            Section {
                Button("Save") {
                    let newBook = Book(context: moc)
                    newBook.id = UUID()
                    newBook.title = title
                    newBook.author = author
                    newBook.rating = Int16(rating)
                    newBook.genre = genre
                    newBook.review = review
                    newBook.date = Date.now

                    try? moc.save()
                    dismiss()
                }
                // Challenge 1:
                .disabled(hasValidEntry == false)
            }
        }
        .navigationTitle("Add Book")
    }
}

// MARK: - AddBookView_Previews

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
