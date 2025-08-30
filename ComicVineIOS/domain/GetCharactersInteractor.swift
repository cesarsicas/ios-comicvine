//
//  GetCharactersInteractor.swift
//  ComicVineIOS
//
//  Created by Julio Siqueira on 30/08/25.
//

class GetCharactersInteractor {
    private let service: GetCharactersService

    init(service: GetCharactersService = GetCharactersService()) {
        self.service = service
    }

    func execute(limit: Int, offset: Int) async throws -> [CharacterDomain] {
        let responseDTO = try await service.getCharacters(limit: limit, offset: offset)

        return responseDTO.results.map { dto in
            // Map the DTO to a domain model
            CharacterDomain(
                  name: dto.name,
                  aliases: dto.aliases ?? "",
                  imageUrl: dto.image.mediumUrl,
                  description: dto.deck ?? ""
              )
        }
    }
}
