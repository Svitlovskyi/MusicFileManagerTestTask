//
//  MockDataService.swift
//  MusicFileManagerApp
//
//  Created by Maksym Svitlovskyi on 23.03.2022.
//

import Foundation


public protocol MusicNetworkServiceProtocol {
    func getMusic(completion: @escaping (Result<[MusicDTOModel], Error>) -> Void)
}

enum MockDataServiceErrors: Error {
    case urlNotExist
}

class MockDataService: MusicNetworkServiceProtocol {
    func getMusic(completion: @escaping (Result<[MusicDTOModel], Error>) -> Void)  {
        let memoryManager = FileSystemManager()
        guard let url = Bundle.main.url(forResource: "mockMusicData", withExtension: "json") else {
            return completion(.failure(MockDataServiceErrors.urlNotExist))
        }
        
        switch memoryManager.read(at: url) {
        case .success(let data):
            do {
                let musics = try JSONDecoder().decode([MusicDTOModel].self, from: data)
                return completion(.success(musics))
            } catch {
                return completion(.failure(error))
            }
        case .failure(let error):
            return completion(.failure(error))
        }
    }
    
    func createMockFileSystemData() {
        getMusic { result in
            switch result {
            case .success(let musicDTO):
                let memoryManager = FileSystemManager()
                musicDTO.forEach {
                    do {
                        let data = try JSONEncoder().encode($0)
                        if !memoryManager.isExist(file: $0.url) {
                            try memoryManager.create(file: $0.url, content: data)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
