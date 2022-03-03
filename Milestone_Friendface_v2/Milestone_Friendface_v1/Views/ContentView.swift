//
//  ContentView.swift
//  Milestone_Friendface_v1
//
//  Created by Blaine Dannheisser on 2/17/22.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    let networkManager = NetworkManager()
    @State private var users = [User]()

    var body: some View {
        NavigationView {
            List(cachedUsers) { user in
                NavigationLink {
                    DetailView(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundColor(user.isActive ? .green : .red)
                            Text(user.wrappedName)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        Text("Company: \(user.wrappedCompany)")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .padding(.leading)
                    }
                }
            }
            .navigationTitle("FriendFace")

            .task {
                if cachedUsers.isEmpty {
                    if let loadedUsers = await networkManager.getUsers() {
                        users = loadedUsers
                    }

                    await MainActor.run {
                        for user in users {
                            let savedUser = CachedUser(context: moc)
                            savedUser.id = user.id
                            savedUser.name = user.name
                            savedUser.company = user.company
                            savedUser.age = Int16(user.age)
                            savedUser.about = user.about
                            savedUser.isActive = user.isActive
                            savedUser.email = user.email
                            savedUser.address = user.address
                            savedUser.registered = user.registered

                            for friend in user.friends {
                                let savedFriend = CachedFriend(context: moc)
                                savedFriend.id = friend.id
                                savedFriend.name = friend.name
                            }
                            try? moc.save()
                        }
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
