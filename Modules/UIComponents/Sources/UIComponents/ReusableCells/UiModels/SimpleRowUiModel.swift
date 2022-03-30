//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import Foundation


public struct SimpleRowUiModel: Identifiable {
    public var id: UUID
    public var title: String
    public var trailingItem: String

    public init(id: UUID, title: String, trailingItem: String) {
        self.id = id
        self.title = title
        self.trailingItem = trailingItem
    }
}

