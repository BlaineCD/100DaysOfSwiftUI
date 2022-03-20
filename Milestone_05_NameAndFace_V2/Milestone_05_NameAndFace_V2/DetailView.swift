//
//  DetailView.swift
//  Milestone_05_NameAndFace_V2
//
//  Created by Blaine Dannheisser on 3/19/22.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    var friend: Friend

    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: friend.photo!)!)
                .resizable()
                .frame(width: 220, height: 220)
                .clipShape(Circle())
                .overlay(Circle().stroke(.blue, lineWidth: 4))
                .padding(.trailing)
                .shadow(color: .gray, radius: 5.0)
                .padding(.bottom)

            Text(friend.wrappedName)
                .font(.title)

            Spacer()
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
