//
//  CharacterDetailsScreen.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 08/08/25.
//

import SwiftUI

struct CharacterDetailsScreen: View {
    let character: Character
    
    var body: some View {
        ScrollView { // Use ScrollView for dynamic content
            VStack(alignment: .center, spacing: 15) { // Add spacing
                // Character Image
                AsyncImage(url: URL(string: character.imageUrl)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit) // Use aspect ratio for better sizing
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 10)
                            .padding(.horizontal)
                            .frame(maxWidth: 400, maxHeight: 300) // Constrain max width for larger screens
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .foregroundColor(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal)
                    case .empty:
                        ProgressView()
                            .frame(height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                // Character Name
                Text(character.name)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                
                // Character Alias (if available)
                if !character.aliases.isEmpty {
                    Text("(\(character.aliases))")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }

                Divider()

                // Character Description
                VStack(alignment: .leading, spacing: 10) {
                    Text("Description")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(character.description)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
            .padding(.vertical) // Add vertical padding to the content
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let character =  Character(
        name: "Spider-Man",
        aliases: "Spider",
        imageUrl: "https://comicvine.gamespot.com/a/uploads/scale_small/12/124259/8126579-amazing_spider-man_vol_5_54_stormbreakers_variant_textless.jpg",
        description: "Spider-Man is the Neighbourhood Best Friend"
    )
    
    CharacterDetailsScreen(character: character)
}
