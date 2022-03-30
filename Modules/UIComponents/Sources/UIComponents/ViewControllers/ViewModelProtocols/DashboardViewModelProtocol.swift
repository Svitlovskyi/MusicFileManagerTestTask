//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 23.03.2022.
//

import UIKit


public protocol DashboardViewModelProtocol {
    var diffableDataSource: DashboardTableViewDataSource? { get set }
    var snapshot: NSDiffableDataSourceSnapshot<DashboardSectionUiModel, DashboardCellUiModel>? { get }
    func applySnapshot()
    func trailingCollectionButtonDidTapped(with id: UUID)
    func viewWillAppear()
}
