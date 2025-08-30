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
    let baseUrl = "https://comicvine.gamespot.com/api/characters"

    func getCharacters(limit: Int, offset: Int) async throws -> GetCharactersResponseDTO {
        var components = URLComponents(string: baseUrl)!
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
}
