//
//  DTOConverter.swift
//  MusicFileManagerApp
//
//  Created by Maksym Svitlovskyi on 23.03.2022.
//

import Foundation

enum DTOConverterErrors: Error {
    case missingField
}

struct DTOConverter  {
    func convertDTOToMusic(dto: MusicDTOModel) -> Result<Music, Error> {
        guard let url = URL(string: dto.url) else { return .failure(DTOConverterErrors.missingField) }
        
        return .success(
            Music(
                id: dto.id,
                name: dto.name,
                author: dto.author,
                genre: dto.genre,
                size: dto.size,
                duration: dto.duration,
                url: url,
                data: nil
            )
        )
    }
}
