//
//  ContentView-ViewModel.swift
//  Project_14_BucketList
//
//  Created by Blaine Dannheisser on 3/11/22.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.13343, longitude: 11.76721), span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20))
        
        @Published private(set) var locations: [Location]
        
        @Published var selectedLocation: Location?

        @Published var isUnlocked = false

        @Published var isShowingAuthError = false
        @Published var authErrorMessage = ""
        

        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }

        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Authentication required to view places"

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    Task { @MainActor in
                        if success {
                            self.isUnlocked = true
                        } else {
                            self.isShowingAuthError = true
                            self.authErrorMessage = "You can not be authenticated. Try again."
                            }
                        }
                    }
                } else {
                    // iOS provides error message free. No need to create
//                    isShowingAuthError = true
//                    authErrorMessage = "Your device does not support biometric authentication."
                }
            }
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }

        func update(location: Location) {
            guard let selectedLocation = selectedLocation else { return }

            if let index = locations.firstIndex(of: selectedLocation) {
                locations[index] = location
                save()
            }
        }
    }
}
