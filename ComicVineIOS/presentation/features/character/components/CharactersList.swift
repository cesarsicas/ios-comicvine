//
//  CharactersList.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 31/08/25.
//
import SwiftUI

struct CharacterList: View {
    let characters: [Character]
    let isLoading: Bool
    var onInitialLoad: () -> Void
    var onPaginate: () -> Void

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(characters) { character in
                        NavigationLink(
                            destination: CharacterDetailsScreen(
                                character: character
                            )
                        ) {
                            CharacterItem(imageUrlString: character.imageUrl)
                        }
                    }
                }
            }

            if !isLoading && !characters.isEmpty {
                HStack {
                    Button(action: {
                        Task {
                            onPaginate()
                        }
                    }) {
                        Text("Load More")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(12)
                            .shadow(
                                color: Color.black.opacity(0.2),
                                radius: 4,
                                x: 0,
                                y: 2
                            )
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
        .task {
            onInitialLoad()
        }
    }
}
