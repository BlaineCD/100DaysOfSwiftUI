//
//  ContentView.swift
//  Milestone_05_NameAndFace_V2
//
//  Created by Blaine Dannheisser on 3/19/22.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var friends: FetchedResults<Friend>

    @State private var isShowingAddFriend = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section("Friends") {
                    ForEach(friends) {friend in
                        NavigationLink {
                            DetailView(friend: friend)
                        } label: {
                            HStack {
                                Image(uiImage: UIImage(data: friend.photo!)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 85, height: 85)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(.blue, lineWidth: 4))
                                    .padding(.trailing)

                                Text(friend.wrappedName)
                                    .font(.title3)
                                }
                            }
                        }
                    .onDelete(perform: deleteFriend)
                    }
                }
                HStack {
                    Spacer()
                    Button {
                        isShowingAddFriend.toggle()
                        print("Add Friend")
                    } label: {
                        Image(systemName: "person.badge.plus")
                            .padding()
                            .font(.title)
                            .foregroundColor(.white)
                            .background(.blue.opacity(0.85))
                            .clipShape(Circle())
                            .shadow(color: .gray, radius: 5.0)
                            .padding(.trailing)
                    }
                }
            }
            .navigationTitle("Name+Face")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .sheet(isPresented: $isShowingAddFriend) {
                AddFriendView()
            }
        }
    }

    func deleteFriend(at offsets: IndexSet) {
        for offset in offsets {
            let friend = friends[offset]
            moc.delete(friend)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
