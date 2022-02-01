//
//  DetailView.swift
//  Project_11_Bookworm
//
//  Created by Blaine Dannheisser on 2/1/22.
//

import SwiftUI

struct DetailView: View {
    var book: Book

    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption.weight(.black))
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }

            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)

            Text(book.review ?? "No Review")
                .padding()

            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Title")
        .navigationBarTitleDisplayMode(.inline)

        .alert("Delete Book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are You Sure")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete This Book", systemImage: "trash")
            }
        }
    }

    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
}

// struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
// }
