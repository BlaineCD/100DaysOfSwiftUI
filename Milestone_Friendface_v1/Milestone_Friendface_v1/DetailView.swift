//
//  DetailView.swift
//  Milestone_Friendface_v1
//
//  Created by Blaine Dannheisser on 2/17/22.
//

import SwiftUI

struct DetailView: View {
    let user: User
    let columns = [
        GridItem(.adaptive(minimum: 170))
    ]

    var body: some View {
        ScrollView {
            VStack {
                HeaderView(userName: user.name, userCompany: user.company, userActivity: user.isActive)

                RectangleSpacer()

                AboutView(userAge: user.age, userInfo: user.about, userEmail: user.email, userAddress: user.address)

                RectangleSpacer()

                UserFriends(userFriends: user.friends)
            }
        }
    }
}

// struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(user: User)
//    }
// }
