//
//  Character.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 08/08/25.
//
import Foundation

struct Character: Identifiable {
    let id = UUID().uuidString // A unique identifier for each character
    let name: String
    let imageUrlString: String
}
