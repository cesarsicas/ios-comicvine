//
//  CharactersViewModel.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 30/08/25.
//

import Foundation

@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var offset: Int = 0
    private let limit: Int = 5

    private let interactor: GetCharactersInteractor

    init(interactor: GetCharactersInteractor = GetCharactersInteractor()) {
        self.interactor = interactor
    }

    func loadInitialCharacters() async {
            isLoading = true
            errorMessage = nil
            self.offset = 0 // Reset offset for initial load

            do {
                let fetchedCharacters = try await interactor.execute(limit: limit, offset: offset)
                self.characters = fetchedCharacters.map { domain in
                    Character(
                        name: domain.name,
                        aliases: domain.aliases,
                        imageUrl: domain.imageUrl,
                        description: domain.description
                    )
                }
            } catch {
                errorMessage = "Failed to load characters: \(error.localizedDescription)"
            }

            isLoading = false
        }
    
    func loadMoreCharacters() async {
            guard !isLoading else { return } // Prevent multiple simultaneous calls
            isLoading = true
            
            do {
                self.offset += self.limit
                let newCharacters = try await interactor.execute(limit: limit, offset: offset)
                let mappedCharacters = newCharacters.map { domain in
                    Character(
                        name: domain.name,
                        aliases: domain.aliases,
                        imageUrl: domain.imageUrl,
                        description: domain.description
                    )
                }
                self.characters.append(contentsOf: mappedCharacters) // Append new data
            } catch {
                errorMessage = "Failed to load more characters: \(error.localizedDescription)"
            }
            
            isLoading = false
        }
}
