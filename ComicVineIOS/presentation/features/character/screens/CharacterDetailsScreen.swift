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
        VStack {
            AsyncImage(url: URL(string: character.imageUrlString)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()

            Text(character.name)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .navigationTitle(character.name) // Set the title here
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let character = Character(name: "Dr Strange", imageUrlString: "https://comicvine.gamespot.com/a/uploads/scale_small/12/124259/8753901-ezgif-3-69b95d2d1b.jpg")
    
    CharacterDetailsScreen(character: character)
}
