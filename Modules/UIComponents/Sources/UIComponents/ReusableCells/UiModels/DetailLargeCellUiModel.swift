//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import UIKit


public struct DetailLargeCellUiModel: Identifiable, Hashable {
    public var id: Int
    public var image: UIImage
    public var title: String
    public var leadingCaption: String
    public var trailingCaption: String
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public init(
        id: Int,
        image: UIImage,
        title: String,
        leadingCaption: String,
        trailingCaption: String
    ) {
        self.id = id
        self.image = image
        self.title = title
        self.leadingCaption = leadingCaption
        self.trailingCaption = trailingCaption
    }
    
}
