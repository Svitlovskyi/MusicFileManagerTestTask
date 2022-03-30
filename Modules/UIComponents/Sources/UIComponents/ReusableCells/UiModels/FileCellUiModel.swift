//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import Foundation


public struct FileCellUiModel: Identifiable, Hashable {
    public var id: Int
    public var title: String
    public var caption: String
    public var isInMemory: Bool
    
    public init(id: Int, title: String, caption: String, isInMemory: Bool) {
        self.title = title
        self.caption = caption
        self.isInMemory = isInMemory
        self.id = id
    }
}
