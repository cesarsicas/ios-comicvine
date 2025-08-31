//
//  ComicVineService.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 30/08/25.
//
import Foundation


// This service handles the actual API call.
import Foundation

class GetCharactersService {
    let apiKey = ""
    let baseUrl = "https://comicvine.gamespot.com/api/"
    
    let charactersEndpoint = "characters"
    let searchEndPoint = "search"

    func getCharacters(limit: Int, offset: Int) async throws -> GetCharactersResponseDTO {
        var components = URLComponents(string: baseUrl+charactersEndpoint)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(GetCharactersResponseDTO.self, from: data)
    }
    
    func searchCharacters(query:String, limit: Int, offset: Int) async throws -> GetCharactersResponseDTO {
        var components = URLComponents(string: baseUrl+searchEndPoint)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "query", value: "\(query)"),
            URLQueryItem(name: "resources", value: "character"),
            URLQueryItem(name: "resource_type", value: "character"),

        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(GetCharactersResponseDTO.self, from: data)
    }
}
