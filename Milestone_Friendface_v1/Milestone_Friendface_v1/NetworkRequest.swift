//
//  NetworkRequest.swift
//  Milestone_Friendface_v1
//
//  Created by Blaine Dannheisser on 2/17/22.
//

import Foundation

struct NetworkRequest {
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
