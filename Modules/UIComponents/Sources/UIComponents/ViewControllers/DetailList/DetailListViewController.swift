//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import UIKit



public class DetailListViewController: UIViewController, UITableViewDelegate {
    public var viewModel: DetailListViewModelProtocol!
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FileCell.self, forCellReuseIdentifier: ReusableIdentifiers.fileCell)
        tableView.delegate = self
        return tableView
    }()
    
    public override func loadView() {
        super.loadView()
        view = tableView
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createDataSource()
    }
    
    private func createDataSource() {
        viewModel.diffableDataSource = UITableViewDiffableDataSource(
            tableView: tableView) { tableView, indexPath, itemIdentifier in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ReusableIdentifiers.fileCell
                ) as? FileCell else {
                    return UITableViewCell()
                }
                
                cell.configure(with: itemIdentifier, buttonAction: { [weak self] in
                    self?.viewModel.buttonDidTapped(with: itemIdentifier.id)
                })
                
                return cell
            }
    }
}
