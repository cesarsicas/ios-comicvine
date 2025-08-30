//
//  CharacteresList.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 08/08/25.
//

import SwiftUI


struct CharacteresList: View {
    let characters: [Character]
    let isLoading: Bool
    let errorMessage: String?
    let loadMore: () async -> Void
    
    @State private var lastViewedCharacterId: UUID?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollViewReader { proxy in
            // Move the conditional logic inside the ScrollViewReader
            if isLoading && characters.isEmpty {
                ProgressView("Loading...")
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(characters) { character in
                            NavigationLink(destination: CharacterDetailsScreen(character: character)) {
                                CharacterItem(imageUrlString: character.imageUrl)
                            }
                            .id(character.id)
                            .onAppear {
                                self.lastViewedCharacterId = character.id
                                if character == characters.last {
                                    Task {
                                        await loadMore()
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    
                    if isLoading && !characters.isEmpty {
                        ProgressView()
                            .padding()
                    }
                }
                .onChange(of: characters.count) {
                    if characters.count > 0, let lastId = lastViewedCharacterId {
                        withAnimation {
                            proxy.scrollTo(lastId, anchor: .bottom)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    
    let characters = [
        Character(
            name: "Spider-Man",
            aliases: "Spider",
            imageUrl: "https://comicvine.gamespot.com/a/uploads/scale_small/12/124259/8126579-amazing_spider-man_vol_5_54_stormbreakers_variant_textless.jpg",
            description: ""
        ),
        Character(
            name: "Iron Man",
            aliases: "Tony Stark",
            imageUrl: "https://comicvine.gamespot.com/a/uploads/scale_small/12/124259/8654427-ezgif-1-2f113089e4.jpg",
            description: ""
        ),
        Character(
            name: "Batman",
            aliases: "The Dark Knight",
            imageUrl: "https://comicvine.gamespot.com/a/uploads/scale_small/11144/111442876/8759934-jrjrhr.jpg",
            description: ""
        ),
        Character(
            name: "Wolverine",
            aliases: "Logan",
            imageUrl: "https://comicvine.gamespot.com/a/uploads/scale_small/11161/111612243/9575315-3753315455-latest.jpg",
            description: ""
        ),
        Character(
            name: "Dr Strange",
            aliases: "Stephen Strange",
            imageUrl: "https://comicvine.gamespot.com/a/uploads/scale_small/12/124259/8753901-ezgif-3-69b95d2d1b.jpg",
            description: ""
        ),
        Character(
            name: "Thor",
            aliases: "God of Thunder",
            imageUrl: "https://comicvine.gamespot.com/a/uploads/scale_small/11139/111399535/9140994-20231020_153307~3.jpg",
            description: ""
        )
    ]
    CharacteresList(
        characters: characters,
        isLoading: false,
        errorMessage: ""){
        }
}
