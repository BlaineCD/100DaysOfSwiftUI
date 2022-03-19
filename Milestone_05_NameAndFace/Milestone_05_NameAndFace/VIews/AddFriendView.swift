//
//  AddFriendView.swift
//  Milestone_05_NameAndFace
//
//  Created by Blaine Dannheisser on 3/16/22.
//

import CoreImage
import SwiftUI

// MARK: - AddFriendView

struct AddFriendView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var title = ""
    @State private var employer = ""
    @State private var notes = ""

    @State private var image: Image?
    @State private var inputImage: UIImage?

    @State private var isShowingPhotoPicker = false

    var hasValidEntry: Bool {
        if image != nil && name != "" {
            return false
        }
        return true
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Image(systemName: "person.fill.viewfinder")
                        .padding(40)
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.system(size: 100))
                        .cornerRadius(20)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)

                    image?
                        .resizable()
                        .frame(width: 200, height: 200)
                        .cornerRadius(20)
                }
                .onTapGesture {
                    isShowingPhotoPicker = true
                }
                Form {
                    Section("Add Info") {
                        TextField("Name...", text: $name)
                            .padding(.top)
                            .textFieldStyle(.roundedBorder)

                        TextField("Title...", text: $title)
                            .textFieldStyle(.roundedBorder)

                        TextField("Employer...", text: $employer)
                            .textFieldStyle(.roundedBorder)

                        TextField("Notes...", text: $notes)
                            .padding(.bottom)
                            .textFieldStyle(.roundedBorder)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Add Contact")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let convertedImage = inputImage?.jpegData(compressionQuality: 0.80)

                        let newPerson = Person(context: moc)
                        newPerson.id = UUID()
                        newPerson.name = name
                        newPerson.title = title
                        newPerson.employer = employer
                        newPerson.notes = notes
                        newPerson.photo = convertedImage

                        try? moc.save()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(hasValidEntry == true)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }

                }
            }
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $isShowingPhotoPicker) {
                ImagePicker(image: $inputImage)
            }
        }
    }

    // MARK: Internal

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

// MARK: - AddFriendView_Previews

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView()
    }
}
