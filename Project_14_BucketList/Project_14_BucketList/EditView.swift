//
//  EditView.swift
//  Project_14_BucketList
//
//  Created by Blaine Dannheisser on 3/10/22.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss

    var location: Location

    @State private var name: String
    @State private var description: String

    var onSave: (Location) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section("Location Details:") {
                    TextField("Place Name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Location Details")
            .toolbar {
                Button {
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description

                    onSave(newLocation)
                    dismiss()
                } label: {
                    Text("Save")
                }

            }
        }
    }
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { newLocation in }
    }
}
