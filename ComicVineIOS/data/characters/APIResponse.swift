//
//  APIResponse.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 30/08/25.
//

struct APIResponse: Decodable {
    let results: [CharacterData]
    let number_of_page_results: Int
    let number_of_total_results: Int
    let limit: Int
    let offset: Int
}
