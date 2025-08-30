//
//  ContentView.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 08/08/25.
//

import SwiftUI


import SwiftUI

import SwiftUI

struct CharactersScreen: View {
    @StateObject private var viewModel = CharacterViewModel()
    @SceneStorage("lastViewedCharacterId") private var lastViewedCharacterId: String?
    @State private var didRestoreScroll = false
    @State private var activeCharacterId: UUID?

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.characters) { character in
                            Button {
                                activeCharacterId = character.id
                                lastViewedCharacterId = character.id.uuidString
                            } label: {
                                CharacterItem(imageUrlString: character.imageUrl)
                            }
                            .id(character.id)
                            .onAppear {
                                // Infinite scroll, load more at end
                                if character.id == viewModel.characters.last?.id {
                                    Task {
                                        await viewModel.loadMoreCharacters()
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .task {
                    // Load initial data
                    await viewModel.loadInitialCharacters()

                    // Restore scroll position only after initial characters are loaded
                    if !didRestoreScroll,
                       let lastId = lastViewedCharacterId,
                       let uuid = UUID(uuidString: lastId),
                       viewModel.characters.contains(where: { $0.id == uuid }) {
                           proxy.scrollTo(uuid, anchor: .top)
                           didRestoreScroll = true
                       }
                }
                .navigationDestination(item: $activeCharacterId) { id in
                    if let character = viewModel.characters.first(where: { $0.id == id }) {
                        CharacterDetailsScreen(character: character)
                    }
                }
            }
        }
    }
}

#Preview {
    CharactersScreen()
}
