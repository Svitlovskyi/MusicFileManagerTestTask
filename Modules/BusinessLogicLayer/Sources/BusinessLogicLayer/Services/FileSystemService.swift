//
//  MemoryManager.swift
//  MusicFileManagerApp
//
//  Created by Maksym Svitlovskyi on 23.03.2022.
//

import Foundation

enum MemoryManagerErrors: Error {
    case emptyData
}


public class FileSystemService {
    private let fileManager: FileManager
    private let defaultDirectory: URL
    
    public init(
        fileManager: FileManager = FileManager.default,
        defaultDirectory: URL? = nil
    ) {
        self.fileManager = fileManager
        if let defaultDirectory = defaultDirectory {
            self.defaultDirectory = defaultDirectory
        } else {
            ///Force unwrap because documents directory will always exist in iOS application
            self.defaultDirectory = fileManager.urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).first!
        }
    }
    
    func read(file withName: String) -> Result<Data, Error> {
        if let data = fileManager.contents(atPath: defaultDirectory.appendingPathComponent(withName).path) {
            return .success(data)
        } else {
            return .failure(MemoryManagerErrors.emptyData)
        }
    }
    
    func read(at url: URL) -> Result<Data, Error> {
        if let data = fileManager.contents(atPath: url.path) {
            return .success(data)
        } else {
            return .failure(MemoryManagerErrors.emptyData)
        }
    }
    
    func create(file withName: String, content: Data) throws {
        do {
            try content.write(to: defaultDirectory.appendingPathComponent(withName))
        } catch {
            throw error
        }
    }
    
    func create(at url: String, content: Data) throws {
        do {
            try content.write(to: defaultDirectory.appendingPathComponent(url))
        } catch {
            throw error
        }
    }
    
    func isExist(file withName: String) -> Bool {
        return fileManager.fileExists(atPath: defaultDirectory.appendingPathComponent(withName).path)
    }
    
    func isExist(file atURL: URL) -> Bool {
        return fileManager.fileExists(atPath: atURL.path)
    }
    ///TODO: Add UD (update, delete) operations
}
