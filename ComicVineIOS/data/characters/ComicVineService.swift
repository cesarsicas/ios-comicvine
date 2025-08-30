//
//  ComicVineService.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 30/08/25.
//
import Foundation

final class ComicVineService {
    
    private let apiKey: String
    private let baseURL = "https://comicvine.gamespot.com/api"
    private let session: URLSession
    
    init(apiKey: String, session: URLSession = .shared) {
        self.apiKey = apiKey
        self.session = session
    }
    
    func fetchCharacters(limit: Int, offset: Int) async throws -> [CharacterData] {
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        urlComponents.path += "/characters"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await session.data(from: url)
            
            let decoder = JSONDecoder()
            let response = try decoder.decode(APIResponse.self, from: data)
            
            return response.results
        } catch {
            // Provide a more informative error message
            if let decodingError = error as? DecodingError {
                print("Decoding Error: \(decodingError)")
                throw decodingError
            } else {
                print("Network Error: \(error)")
                throw error
            }
        }
    }
}
