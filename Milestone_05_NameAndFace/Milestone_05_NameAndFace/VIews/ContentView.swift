//
//  ContentView.swift
//  Milestone_05_NameAndFace
//
//  Created by Blaine Dannheisser on 3/16/22.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {

    @Environment(\.managedObjectContext) var moc

    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var people: FetchedResults<Person>

    // State toggled to show Add View
    @State private var isShowingAddFriendView = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section("Contacts:") {
                        ForEach(people) { person in
                            NavigationLink {
                                DetailView(person: person)
                            } label: {
                                HStack {
                                    Image(uiImage: UIImage(data: person.photo!)!)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 85, height: 85)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(.yellow, lineWidth: 4)
                                        )
                                        .padding(.trailing)
                                    Text(person.name ?? "Dalai Lama")
                                        .font(.title3)
                                }
                            }
                        }
                        .onDelete(perform: deletePerson)
                    }
                }
            }
            .navigationTitle("Name + Face")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddFriendView = true
                        print("TEST")
                    } label: {
                        Image(systemName: "person.crop.circle.badge.plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $isShowingAddFriendView) {
                AddFriendView()
            }
        }
    }
    func deletePerson(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            moc.delete(person)
        }
        try? moc.save()
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
