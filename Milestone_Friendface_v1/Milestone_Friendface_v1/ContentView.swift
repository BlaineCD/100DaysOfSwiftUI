//
//  ContentView.swift
//  Milestone_Friendface_v1
//
//  Created by Blaine Dannheisser on 2/17/22.
//

import SwiftUI

struct ContentView: View {

    @State private var users = [User]()

    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    DetailView(user: user)
                } label: {
                VStack(alignment: .leading) {
                    HStack {
                    Image(systemName: "circle.fill")
                            .font(.caption)
                            .foregroundColor(user.isActive ? .green : .red)
                    Text(user.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    }
                    Text("Company: \(user.company)")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.leading)
                    }
                }
            }
            .navigationTitle("FriendFace")
            .task {
                if let loadedUsers = await getUsers() {
                    users = loadedUsers
                }
            }
        }
    }

    func getUsers() async -> [User]? {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try decoder.decode([User].self, from: data)
            return decodedData
        } catch {
            print(error)
        }
        return nil
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
