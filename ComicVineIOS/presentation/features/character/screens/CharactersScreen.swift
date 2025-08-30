//
//  ContentView.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 08/08/25.
//

import SwiftUI


import SwiftUI

struct CharactersScreen: View {
    @StateObject private var viewModel = CharacterViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.characters) { character in
                        NavigationLink(destination: CharacterDetailsScreen(character: character)) {
                            CharacterItem(imageUrlString: character.imageUrl)
                        }
                    }
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                // Show "Load More" button if not loading
                if !viewModel.isLoading {
                    Button(action: {
                        Task {
                            await viewModel.loadMoreCharacters()
                        }
                    }) {
                        Text("Load More")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .task {
                await viewModel.loadInitialCharacters()
            }
        }
    }
}

#Preview {
    CharactersScreen()
}
