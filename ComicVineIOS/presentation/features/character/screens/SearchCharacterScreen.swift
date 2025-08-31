//
//  SearchCharacter.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 31/08/25.
//

import SwiftUI

struct SearchCharacter: View {
    @StateObject private var viewModel = SearchCharacterViewModel()
    @State private var searchText = ""

    var body: some View {
        VStack {
            HStack {
                TextField("Search...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)

                Button(action: {
                    Task {
                        await viewModel.initialSearch(query: searchText)
                    }
                }) {
                    Text("Search")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.trailing)
            }
            .padding(.top)

            CharacterList(
                characters: viewModel.characters,
                isLoading: viewModel.isLoading,
                onInitialLoad: {
    
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
    SearchCharacter()
}
