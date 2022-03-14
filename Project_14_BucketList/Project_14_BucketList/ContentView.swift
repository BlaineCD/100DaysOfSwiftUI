//
//  ContentView.swift
//  Project_14_BucketList
//
//  Created by Blaine Dannheisser on 3/7/22.
//

import MapKit
import SwiftUI

// MARK: - ContentView

struct ContentView: View {

    @StateObject private var viewModel = ViewModel()

    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinates) {
                        VStack {
                            Image(systemName: "flag.fill")
                                .resizable()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.red)
                            Text(location.name)
                                .font(.headline)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.selectedLocation = location
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
                            viewModel.addLocation()
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
                .sheet(item: $viewModel.selectedLocation) { place in
                    EditView(location: place) { newLocation in
                        viewModel.update(location: newLocation)
                    }
                }
            }
        } else {
            Button("Unlock Places") {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())

            .alert("Authentication Error", isPresented: $viewModel.isShowingAuthError) {
                Button("OK") {}
            } message: {
                Text(viewModel.authErrorMessage)
                }
            }
        }
    }


// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
