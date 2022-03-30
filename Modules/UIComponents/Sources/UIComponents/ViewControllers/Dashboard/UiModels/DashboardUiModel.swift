//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import Foundation


public struct DashboardUiModel {
    public var sections: [DashboardSectionUiModel]
    
    public init(sections: [DashboardSectionUiModel]) {
        self.sections = sections
    }
}

