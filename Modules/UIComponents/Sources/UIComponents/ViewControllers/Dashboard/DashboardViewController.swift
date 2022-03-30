//
//  File.swift
//
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import UIKit

public class DashboardViewController: UIViewController {
    public var viewModel: DashboardViewModelProtocol!

    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: ReusableIdentifiers.dashboardDefaultTableViewCell
        )
        tableView.register(
            CollectionViewCell.self,
            forCellReuseIdentifier: ReusableIdentifiers.collectionViewCell
        )
        return tableView
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        createDataSource()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()

    }
    
    private func createDataSource() {
        viewModel.diffableDataSource = DashboardTableViewDataSource(
            tableView: tableView,
            cellProvider: createCell(_:indexPath:cellModel:)
        )
        viewModel.applySnapshot()
        tableView.delegate = self
    }
    ///Improve: will be better if i use factory pattern for build UI elements like this
    private func createCell(_ tableView: UITableView, indexPath: IndexPath, cellModel: DashboardCellUiModel) -> UITableViewCell {
        switch cellModel {
        case .detailedCollection(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ReusableIdentifiers.collectionViewCell,
                for: indexPath
            ) as? CollectionViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .simple(let model):
            let cell = UITableViewCell(
                style: .value1,
                reuseIdentifier: ReusableIdentifiers.dashboardDefaultTableViewCell
            )
            cell.textLabel?.text = model.title
            cell.detailTextLabel?.text = model.trailingItem
            return cell
        }
    }
    ///Improve: Separate UIView from UIViewController
    private func setupLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DashboardViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.snapshot?.sectionIdentifiers[indexPath.section].content[indexPath.row] {
        case .simple:
            return tableView.estimatedRowHeight
        case .detailedCollection:
            return UIScreen.main.bounds.width*0.6+20
        case .none:
            return tableView.estimatedRowHeight
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderWithButtonView()
        guard let model = viewModel.snapshot?.sectionIdentifiers[section] else { return nil }
        view.configure(with: model.title, buttonTitle: model.trailingButtonTitle, buttonAction: { [weak self] in
            self?.viewModel.trailingCollectionButtonDidTapped(with: model.id)
        })
        return view
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}


