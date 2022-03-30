//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import UIKit

public struct DashboardSectionUiModel: Hashable {
    public var id: UUID
    public var title: String
    public var trailingButtonTitle: String
    public var content: [DashboardCellUiModel]
    
    public init(id: UUID, title: String, trailingButtonTitle: String, content: [DashboardCellUiModel]) {
        self.id = id
        self.title = title
        self.trailingButtonTitle = trailingButtonTitle
        self.content = content
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(content)
    }
}

