//
//  GetCharactersResponseDTO.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 30/08/25.
//

struct GetCharactersResponseDTO: Decodable {
    let error: String
    let limit: Int
    let offset: Int
    let results: [CharacterDTO]
}

struct CharacterDTO: Decodable {
    let name: String
    let aliases: String?
    let deck: String?
    let description:String?
    let image: ImageDTO
    let siteDetailUrl: String

    // Custom coding keys to handle different property names
    enum CodingKeys: String, CodingKey {
        case name, aliases, deck, description, image
        case siteDetailUrl = "site_detail_url"
    }
}

struct ImageDTO: Decodable {
    let iconUrl: String
    let mediumUrl: String
    let originalUrl: String
    let smallUrl: String

    enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url"
        case mediumUrl = "medium_url"
        case originalUrl = "original_url"
        case smallUrl = "small_url"
    }
}
