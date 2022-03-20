//
//  AddFriendView.swift
//  Milestone_05_NameAndFace_V2
//
//  Created by Blaine Dannheisser on 3/19/22.
//

import SwiftUI

struct AddFriendView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var photo: Image?
    @State private var inputPhoto: UIImage?

    @State private var isShowingPhotoPicker = false

    var hasValidEntry: Bool {
        if photo != nil && name != "" {
            return false
        }
        return true
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .padding(50)
                        .background(.blue.opacity(85))
                        .foregroundColor(.white)
                        .font(.system(size: 100))
                        .clipShape(Circle())
                        .shadow(color: .gray, radius: 5.0)

                    photo?
                        .resizable()
                        .frame(width: 220, height: 220)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.blue, lineWidth: 4))
                        .shadow(color: .gray, radius: 5.0)
                }
                .onTapGesture {
                    isShowingPhotoPicker = true
                }

                TextField("Name...", text: $name)
                    .padding()
                    .textFieldStyle(.roundedBorder)

                Spacer()
            }
            .onChange(of: inputPhoto, perform: { newValue in
                loadPhoto()
            })
            .sheet(isPresented: $isShowingPhotoPicker) {
                ImagePicker(photo: $inputPhoto)
            }
            .navigationTitle("Add Friend")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveFriend()
                        dismiss()
                    }
                    .disabled(hasValidEntry == true)
                }
            }
        }
    }

    func loadPhoto() {
        guard let inputPhoto = inputPhoto else { return }
        photo = Image(uiImage: inputPhoto)
    }

    func saveFriend() {
        guard let savedPhoto = inputPhoto?.jpegData(compressionQuality: 0.80) else { return }

        let newFriend = Friend(context: moc)
        newFriend.id = UUID()
        newFriend.name = name
        newFriend.photo = savedPhoto
        try? moc.save()
    }
}

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView()
    }
}
