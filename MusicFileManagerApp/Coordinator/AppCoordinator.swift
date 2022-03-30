//
//  AppCoordinator.swift
//  MusicFileManagerApp
//
//  Created by Maksym Svitlovskyi on 23.03.2022.
//

import UIKit
import UIComponents
import BusinessLogicLayer

public class AppCoordinator {
    private lazy var repository = MusicRepository(networkService: MockDataService())
    lazy var navigationController = UINavigationController(rootViewController: dashboardViewController)
    
    private lazy var dashboardViewController: DashboardViewController = {
        let viewController = DashboardViewController()
        let viewModel = DashboardViewModel(repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }()
    
    
    func moveToSeeAll(with viewModel: DetailListViewModel) {
        let viewController = DetailListViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
