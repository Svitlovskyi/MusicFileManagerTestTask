//
//  Music.swift
//  MusicFileManagerApp
//
//  Created by Maksym Svitlovskyi on 23.03.2022.
//

import Foundation


public class Music: NSObject {
    public let id: Int
    public let name: String
    public let author: String
    public let genre: String
    public let size: Int /// in bytes
    public let url: URL
    @objc dynamic public let duration: Int /// in seconds
    @objc dynamic public var data: Data?
    
    internal init(id: Int, name: String, author: String, genre: String, size: Int, duration: Int, url: URL, data: Data? = nil) {
        self.id = id
        self.name = name
        self.author = author
        self.genre = genre
        self.size = size
        self.duration = duration
        self.url = url
        self.data = data
    }
}
