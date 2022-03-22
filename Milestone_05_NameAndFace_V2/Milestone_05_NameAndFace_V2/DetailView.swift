//
//  DetailView.swift
//  Milestone_05_NameAndFace_V2
//
//  Created by Blaine Dannheisser on 3/19/22.
//

import MapKit
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    
    var friend: Friend

    var body: some View {
        NavigationView {
            VStack {
            ZStack {
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: friend.latitude, longitude: friend.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.blue, lineWidth: 4))
                    .shadow(color: .gray, radius: 5.0)

                Image(uiImage: UIImage(data: friend.photo!)!)
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.blue, lineWidth: 4))
                    .padding(.trailing)
                    .shadow(color: .gray, radius: 5.0)
            }
                Spacer()
            }

            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(friend.wrappedName)
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
