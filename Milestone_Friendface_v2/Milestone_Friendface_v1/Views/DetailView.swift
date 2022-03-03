//
//  DetailView.swift
//  Milestone_Friendface_v1
//
//  Created by Blaine Dannheisser on 2/17/22.
//

import SwiftUI

struct DetailView: View {
    let user: CachedUser

    let columns = [
        GridItem(.adaptive(minimum: 170))
    ]

    var body: some View {
        ScrollView {
            VStack {
                HeaderView(userName: user.wrappedName, userCompany: user.wrappedCompany, userActivity: user.isActive)

                RectangleSpacer()

                AboutView(userAge: Int(user.age), userInfo: user.wrappedAbout, userEmail: user.wrappedEmail, userAddress: user.wrappedAddress)

                RectangleSpacer()
                
                Text("Friends:")
                    .font(.title2.bold())

                LazyVGrid(columns: columns) {
                    ForEach(user.friendsArray) { currentUser in
                        VStack {
                            Image(systemName: "person.circle")
                                .font(.title)
                            Text(currentUser.wrappedFriendName)
                        }
                    }
                }
            }
        }
    }
}

// struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(user: User)
//    }
// }
