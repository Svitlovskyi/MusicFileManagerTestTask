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

public enum MockDataServiceErrors: Error {
    case urlNotExist
}

public class MockDataService: MusicNetworkServiceProtocol {
    public func getMusic(completion: @escaping (Result<[MusicDTOModel], Error>) -> Void)  {
        let memoryManager = FileSystemService()
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
    
    public func createMockFileSystemData() {
        getMusic { result in
            switch result {
            case .success(let musicDTO):
                let memoryManager = FileSystemService()
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
    
    public init() { }
}
