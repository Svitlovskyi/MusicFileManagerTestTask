//
//  File 2.swift
//  
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import Foundation


public struct CollectionViewCellUiModel: Identifiable {
    public var id: UUID = UUID()
    public var content: [DetailLargeCellUiModel]
    
    public init(id: UUID = UUID(), content: [DetailLargeCellUiModel]) {
        self.id = id
        self.content = content
    }
}
