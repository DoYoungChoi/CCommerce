//
//  NetworkService.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import Foundation

class NetworkService {
    static let shared: NetworkService = .init()
    
    func getHomeData() async throws -> HomeResponse {
        let urlString = "https://my-json-server.typicode.com/JeaSungLee/JsonAPIFastCampus/db"
        guard let url = URL(string: urlString)
        else { throw URLError(.badURL) }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else { throw URLError(.badServerResponse) }
        
        let decodedData = try JSONDecoder().decode(HomeResponse.self, from: data)
        return decodedData
    }
}
