//
//  MusicDTOModel.swift
//  MusicFileManagerApp
//
//  Created by Maksym Svitlovskyi on 23.03.2022.
//

import Foundation


public struct MusicDTOModel: Codable {
    public let id: Int
    public let name: String
    public let author: String
    public let genre: String
    public let size: Int /// in kilobytes
    public let duration: Int /// in seconds
    public let url: String
    public let imageName: String
}
