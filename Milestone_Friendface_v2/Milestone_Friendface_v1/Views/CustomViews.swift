//
//  CustomViews.swift
//  Milestone_Friendface_v1
//
//  Created by Blaine Dannheisser on 2/17/22.
//

import Foundation
import SwiftUI

// Detail View Header:
struct HeaderView: View {
    var userName: String
    var userCompany: String
    var userActivity: Bool

    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .font(.system(size: 125))
                .foregroundColor(.blue)
                .padding(.bottom)

            Text(userName)
                .font(.title.bold())
            Text(userCompany)
                .font(.title2.bold())

            HStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(userActivity ? .green : .red)
                    .font(.caption)
                Text(userActivity ? "Online" : "Offline")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .frame(width: 300, alignment: .topLeading)
        }
    }
}

struct AboutView: View {
    var userAge: Int
    var userInfo: String
    var userEmail: String
    var userAddress: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Age:")
                    .font(.callout)
                    .fontWeight(.bold)
                Text("\(userAge)")
                    .font(.body)
                    .fontWeight(.semibold)
            }
            .padding(.bottom)

            Text("About:")
                .font(.callout)
                .fontWeight(.bold)
            Text(userInfo)
                .font(.body)
                .fontWeight(.semibold)
                .padding(.bottom)

            HStack {
                Image(systemName: "envelope")
                    .font(.callout.bold())
                Link(userEmail, destination: URL(string: "mailto:\(userEmail)")!)
            }
            .padding(.bottom)

            HStack {
                Image(systemName: "house")
                    .font(.callout.bold())
                Text(userAddress)
                    .font(.body)
                    .fontWeight(.semibold)
            }
            .padding(.bottom)
        }
        .padding()
    }
}

//struct UserFriends: View {
//    var userFriends: [CachedFriend]
//
//    let columns = [
//        GridItem(.adaptive(minimum: 170))
//    ]
//
//    var body: some View {
//        VStack {
//            Text("Friends:")
//                .font(.title2.bold())
//
//            LazyVGrid(columns: columns) {
//                ForEach(user.friendsArray) { friend in
//                    VStack {
//                        Image(systemName: "person.circle")
//                            .font(.title)
//                        Text(friend.wrappedFriendName)
//                    }
//                    .padding()
//                }
//            }
//        }
//    }
//}

//Text("Friends:")
//    .font(.title2.bold())
//
//LazyVGrid(columns: columns) {
//    ForEach(user.friends, id: \.id) { friend in
//        VStack {
//            Image(systemName: "person.circle")
//                .font(.title)
//            Text(friend.name)
//        }
//    }
//    .padding()




// Horizontal Bar Seperator:
struct RectangleSpacer: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.blue)
            .padding(.vertical)
    }
}

//var wrappedID: UUID {
//    id ?? UUID()
//}
//
//var wrappedName: String {
//    name ?? "Unknown Name"
//}
//
//var wrappedEmail: String {
//    email ?? "No Email"
//}
//
//var wrappedAddress: String {
//    address ?? "Unkonwn Address"
//}
//
// var wrappedRegistered: Date {
//    registered ?? Date()
//}
//
//var wrappedCompany: String {
//    company ?? "Unknown Company"
//}
//
//var wrappedAbout: String {
//    about ?? ""
//}
//
//var friendsArray: [CachedFriend] {
//    let set = friends as? Set<CachedFriend> ?? []
//
//    return set.sorted {
//        $0.wrappedName < $1.wrappedName
//    }
//}
//}



//
//var wrappedName: String {
//    name ?? "Unknown Name"
//}
