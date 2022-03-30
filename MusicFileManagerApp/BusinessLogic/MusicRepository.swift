//
//  MusicRepository.swift
//  MusicFileManagerApp
//
//  Created by Maksym Svitlovskyi on 23.03.2022.
//

import Foundation
import BusinessLogicLayer

enum MusicRepostitoryErrors: Error {
    case musicNotExist
}

public class MusicRepository {
    private lazy var networkService: MusicNetworkServiceProtocol = MockDataService()
    private lazy var memoryManager: FileSystemManager = FileSystemManager()
    public var musics: [Music] = []
    
    public init(networkService: MusicNetworkServiceProtocol) {
        self.networkService = networkService
        refreshData()
        
    }
    
    public func refreshData() {
        networkService.getMusic { [weak self] result in
            switch result {
            case .success(let musicDTO):
                let dtoConverter = DTOConverter()
                self?.musics = musicDTO.compactMap {
                    return try? dtoConverter.convertDTOToMusic(dto: $0).get()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func saveOrDeleteFromMemory(music withId: Int) -> Error? {
        guard let music = musics.first(where: { $0.id == withId }) else { return MusicRepostitoryErrors.musicNotExist }
        if music.data != nil {
            music.data = nil
            return nil
        } else {
            switch memoryManager.read(file: music.url.absoluteString) {
            case .success(let data):
                music.data = data
                return nil
            case .failure(let error):
                return error
            }
        }
    }
}



