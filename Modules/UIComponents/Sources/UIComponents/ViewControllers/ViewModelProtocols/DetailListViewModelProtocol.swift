//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 23.03.2022.
//

import UIKit


public protocol DetailListViewModelProtocol {
    var diffableDataSource: UITableViewDiffableDataSource<Int, FileCellUiModel>? { get set }
    var snapshot: NSDiffableDataSourceSnapshot<Int, FileCellUiModel>? { get }
    func buttonDidTapped(with id: Int) -> Error?
}
