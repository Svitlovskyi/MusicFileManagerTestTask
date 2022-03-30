//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import Foundation


public enum DashboardCellUiModel: Hashable {
    case simple(model: SimpleRowUiModel)
    case detailedCollection(model: CollectionViewCellUiModel)
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .simple(let model):
            hasher.combine(model.id)
        case .detailedCollection(let model):
            hasher.combine(model.id)
        }
    }
    
    static public func == (lhs: DashboardCellUiModel, rhs: DashboardCellUiModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

