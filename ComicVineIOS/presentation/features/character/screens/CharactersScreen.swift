//
//  ContentView.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 08/08/25.
//

import SwiftUI

struct CharactersScreen: View {
    @StateObject private var viewModel = CharacterViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                CharacteresList(
                    characters: viewModel.characters,
                    isLoading: viewModel.isLoading,
                    errorMessage: viewModel.errorMessage, // Pass the error message
                    loadMore: {
                        await viewModel.loadMoreCharacters()
                    }
                )
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
