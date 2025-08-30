//
//  CharacterData.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 30/08/25.
//

import Foundation

struct CharacterData: Decodable, Identifiable {
    let id: Int
    let name: String
    let real_name: String?
    let image: ImageInfo
    let description: String?

    // Add a unique identifier for use in a SwiftUI List
    var uniqueId: Int {
        return id
    }
    
    struct ImageInfo: Decodable {
        let original_url: String?
        let icon_url: String?
    }
    
    // The API might return HTML in the description. We can create a computed property
    // to remove the HTML tags for a cleaner display.
    var cleanDescription: String? {
        // Simple HTML tag removal (for demonstration purposes)
        return description?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
