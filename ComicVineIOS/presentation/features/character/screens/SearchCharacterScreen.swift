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

            if viewModel.isLoading {
                ProgressView()
                Spacer() // This pushes the ProgressView to the top
            } else {
                if(!viewModel.characters.isEmpty){
                    CharacterList(
                        characters: viewModel.characters,
                        isLoading: viewModel.isLoading,
                        onInitialLoad: {
                            //do nothing
                        },
                        onPaginate: {
                            Task {
                                await viewModel.loadMoreCharacters()
                            }
                        }
                    )
                }
                else{
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    SearchCharacter()
}
