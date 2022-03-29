//
//  AddFriendView.swift
//  Milestone_05_NameAndFace_V2
//
//  Created by Blaine Dannheisser on 3/19/22.
//

import CoreLocation
import SwiftUI

struct AddFriendView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    let locationFetcher = LocationFetcher()

    @State private var name = ""
    @State private var isFavorite = false
    @State private var latitude = 84.99135153345317
    @State private var longitude = 84.99135153345317
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
                        .scaledToFill()
                        .frame(width: 220, height: 220)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.blue, lineWidth: 4))
                        .shadow(color: .gray, radius: 5.0)
                }
                .onTapGesture {
                    isShowingPhotoPicker = true
                    self.locationFetcher.start()
                }

                TextField("Name...", text: $name)
                    .padding()
                    .textFieldStyle(.roundedBorder)

                Toggle("Add Favorite?", isOn: $isFavorite)
                    .padding()
                    .tint(.blue)

                Button("Track Location") {
                    if let location = self.locationFetcher.lastKnownLocation {
                        latitude = location.latitude
                        longitude = location.longitude
                        print("Your location is \(location)")
                    } else {
                        print("Your location is unknown")
                    }
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .font(.headline.bold())
                .cornerRadius(15)

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
        newFriend.favorite = isFavorite
        newFriend.photo = savedPhoto
        newFriend.latitude = latitude
        newFriend.longitude = longitude
        try? moc.save()
    }
}


//struct AddFriendView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddFriendView()
//    }
//}
