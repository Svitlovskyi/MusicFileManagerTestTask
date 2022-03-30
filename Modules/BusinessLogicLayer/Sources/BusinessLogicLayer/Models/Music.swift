//
//  Music.swift
//  MusicFileManagerApp
//
//  Created by Maksym Svitlovskyi on 23.03.2022.
//

import Foundation
import UIKit


public class Music {
    public let id: Int
    public let name: String
    public let author: String
    public let genre: String
    public let size: Float /// in bytes
    public let url: URL
    public let image: UIImage?
    public let duration: Int /// in seconds
    public var data: Data?
    
    internal init(
        id: Int,
        name: String,
        author: String,
        genre: String,
        size: Float,
        duration: Int,
        url: URL,
        data: Data? = nil,
        image: UIImage?
    ) {
        self.id = id
        self.name = name
        self.author = author
        self.genre = genre
        self.size = size
        self.duration = duration
        self.url = url
        self.data = data
        self.image = image
    }
}
