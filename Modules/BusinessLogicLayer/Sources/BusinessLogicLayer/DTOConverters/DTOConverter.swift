//
//  DTOConverter.swift
//  MusicFileManagerApp
//
//  Created by Maksym Svitlovskyi on 23.03.2022.
//

import Foundation
import UIKit

public enum DTOConverterErrors: Error {
    case missingField
}

public struct DTOConverter  {
    public func convertDTOToMusic(dto: MusicDTOModel) -> Result<Music, Error> {
        guard let url = URL(string: dto.url) else { return .failure(DTOConverterErrors.missingField) }
        
        return .success(
            Music(
                id: dto.id,
                name: dto.name,
                author: dto.author,
                genre: dto.genre,
                size: Float(dto.size),
                duration: dto.duration,
                url: url,
                data: nil,
                image: UIImage(named: dto.imageName, in: .main, with: .none)
            )
        )
    }
}
