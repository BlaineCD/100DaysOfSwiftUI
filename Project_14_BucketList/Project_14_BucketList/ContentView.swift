//
//  ContentView.swift
//  Project_14_BucketList
//
//  Created by Blaine Dannheisser on 3/7/22.
//

import MapKit
import SwiftUI

struct ContentView: View {

    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.13343, longitude: 11.76721), span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20))

    @State private var locations = [Location]()

    @State private var selectedLocation: Location?

    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinates) {
                    VStack {
                        Image(systemName: "flag.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.red)
                        Text(location.name)
                            .font(.caption)
                            .fixedSize()
                    }
                    .onTapGesture {
                        selectedLocation = location
                    }
                }
            }
            .ignoresSafeArea()

            Circle()
                .strokeBorder(Color.blue, lineWidth: 2)
                .background(Circle().fill(Color.blue))
                .opacity(0.4)
                .frame(width: 44, height: 44)


            VStack {
                Spacer()

                HStack {
                    Spacer()

                    Button {
                        let newLocation = Location(id: UUID(), name: "", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                        locations.append(newLocation)
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title2)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
        .sheet(item: $selectedLocation) { place in
            EditView(location: place) { newLocation in
                if let index = locations.firstIndex(of: place) {
                    locations[index] = newLocation
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
