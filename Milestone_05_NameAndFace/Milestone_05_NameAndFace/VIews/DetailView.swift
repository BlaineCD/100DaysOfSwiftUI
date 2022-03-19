//
//  DetailView.swift
//  Milestone_05_NameAndFace
//
//  Created by Blaine Dannheisser on 3/18/22.
//

import SwiftUI

struct DetailView: View {
    var person: Person

    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showDeleteAlert = false

    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: person.photo!)!)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.yellow, lineWidth: 4)
                )
                .shadow(color: .gray, radius: 7.5)
                .padding(.bottom)

            Text(person.name ?? "Dalai Lama")
                .font(.title.bold())

            Form {
                Section("Title") {
                    Text(person.title ?? "Spirtual Leader")
                }
                Section("Employer") {
                    Text(person.employer ?? "The Buddha")
                }
                Section("Notes") {
                    Text(person.notes ?? "Went to the same university")
                }
                Section {
                    Button {
                        showDeleteAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete")
                        }
                        .frame(width: 250, height: 44, alignment: .center)
                        .foregroundColor(.white)
                        .background(.red)
                        .cornerRadius(15)
                        .padding()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
            .alert("Delete Contact", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive, action: deleteContact)
                Button("Cancel", role: .cancel) {}
            }
        }
    }

    func deleteContact() {
//        moc.delete(person)
//        try? moc.save()
        print("DELETE")
        dismiss()
    }
}

// struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
// }
