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
        NavigationStack {
            CharacterList(
                characters: viewModel.characters,
                isLoading: viewModel.isLoading,
                onInitialLoad: {
                    Task {
                        await viewModel.loadInitialCharacters()
                    }
                },
                onPaginate: {
                    Task {
                        await viewModel.loadMoreCharacters()
                    }

                }
            )
        }

    }
}

#Preview {
    CharactersScreen()
}
