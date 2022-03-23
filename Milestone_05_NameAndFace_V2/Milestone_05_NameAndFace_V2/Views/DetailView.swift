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
    @State private var animationAmount = 1.0

    var body: some View {
        NavigationView {
            VStack {
                Text(friend.wrappedName)
                    .font(.title)
                ZStack {
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: friend.latitude, longitude: friend.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))))
                        .cornerRadius(25)
                        .shadow(color: .gray, radius: 8)
                        .padding([.bottom, .leading, .trailing])
                    Image(uiImage: UIImage(data: friend.photo!)!)
                        .resizable()
                        .frame(width: 90, height: 90)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.blue, lineWidth: 4))
                        .padding(.trailing)
                        .shadow(color: .orange, radius: 5.0)
                        .scaleEffect(animationAmount)
                        .animation(.easeInOut(duration: 1.2), value: animationAmount)
                        .onTapGesture {
                            if animationAmount == 1.0 {
                                animationAmount += 2
                            } else {
                                animationAmount -= 2
                            }
                        }
                    }
                }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add To Favorites") {
                    friend.favorite = true
                    try? moc.save()
                }
            }
        }

            }
        }

    // struct DetailView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        DetailView()
    //    }
    // }
