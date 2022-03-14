//
//  EditView.swift
//  Project_14_BucketList
//
//  Created by Blaine Dannheisser on 3/10/22.
//

import SwiftUI

// MARK: - EditView

struct EditView: View {

    @StateObject private var editViewModel: EditViewModel

    @Environment(\.dismiss) var dismiss

    var onSave: (Location) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section("Location Details:") {
                    TextField("Place Name", text: $editViewModel.name)
                    TextField("Description", text: $editViewModel.description)
                }
                Section("Nearby...") {
                    switch editViewModel.loadingState {
                    case .loaded:
                        ForEach(editViewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading...")
                    case .failed:
                        Text("Please try again. Network request failed.")
                    }
                }
            }
            .navigationTitle("Location Details")
            .toolbar {
                Button("Save") {
                    let newLocation = editViewModel.createNewLocation()
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await editViewModel.fetchNearbyPlaces()
            }
        }
    }

    // MARK: Lifecycle

    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        _editViewModel = StateObject(wrappedValue: EditViewModel(location: location, name: "", description: ""))
    }
}

// MARK: - EditView_Previews

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(location: Location.example) { newLocation in }
//    }
//}
