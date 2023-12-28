//
//  NetworkService.swift
//  CCommerce
//
//  Created by dodor on 12/22/23.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case responseError
    case serverError(statusCode: Int)
    case decodeError
    case unknownError
}

class NetworkService {
    static let shared: NetworkService = .init()
    
    private let hostURLString: String = "https://my-json-server.typicode.com/JeaSungLee"
    private func createURL(path: String) throws -> URL {
        let urlString = "\(hostURLString)\(path)"
        guard let url = URL(string: urlString) else { throw NetworkError.urlError }
        return url
    }
    
    private func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.responseError }
        
        switch httpResponse.statusCode {
        case 200...299:
            return data
        default:
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
    }
    
    func getHomeData() async throws -> HomeResponse {
        let url = try createURL(path: "/JsonAPIFastCampus/db")
        let data = try await fetchData(from: url)
        do {
            let decodedData = try JSONDecoder().decode(HomeResponse.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodeError
        }
    }
    
    func getFavoriteData() async throws -> FavoriteResponse {
        let url = try createURL(path: "/JsonAPIFastCampusFavorite/db")
        let data = try await fetchData(from: url)
        do {
            let decodedData = try JSONDecoder().decode(FavoriteResponse.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodeError
        }
    }
    
    func getProductDetailData() async throws -> ProductResponse {
        let url = try createURL(path: "/JsonAPIFastCampusProductDetail/db")
        let data = try await fetchData(from: url)
        do {
            let decodedData = try JSONDecoder().decode(ProductResponse.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodeError
        }
    }
}
