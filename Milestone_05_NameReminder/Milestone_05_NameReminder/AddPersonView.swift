//
//  AddPersonView.swift
//  Milestone_05_NameReminder
//
//  Created by Blaine Dannheisser on 3/16/22.
//

import SwiftUI

struct AddPersonView: View {
    @ObservedObject var people: People
    @Environment(\.dismiss) var dismiss
    @State var name: String
    @State private var showingPhotoPicker = false


    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person.badge.plus")
                    .padding(50)
                    .background(.green.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.bottom)
                HStack {
                Text("Add Name:")
                        .padding(.leading)
                TextField("Name", text: $name)
                        .padding(.trailing)
                        .textFieldStyle(.roundedBorder)
                }
                Spacer()
            }
            .toolbar {
                Button("Save") {
                    if name != "" {
                    let newPerson = Person(id: UUID(), name: name)
                        people.people.append(newPerson)
                    }
                    dismiss()
                }
            }
        }
    }
}

//struct AddPersonView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPersonView(people: People, name: "")
//    }
//}
