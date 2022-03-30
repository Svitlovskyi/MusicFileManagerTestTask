//
//  DetailListViewModel.swift
//  MusicFileManagerApp
//
//  Created by Maksym Svitlovskyi on 29.03.2022.
//

import Foundation
import UIKit
import UIComponents
import BusinessLogicLayer

class DetailListViewModel: DetailListViewModelProtocol {
    var uiModel: [FileCellUiModel] = []
    var snapshot: NSDiffableDataSourceSnapshot<Int, FileCellUiModel>?
    var diffableDataSource: UITableViewDiffableDataSource<Int, FileCellUiModel>? {
        didSet {
            applySnapshot()
        }
    }
    
    var repository: MusicRepository
    
    init(repository: MusicRepository, for genre: String) {
        self.repository = repository
        uiModel = repository.musics.compactMap {
            if genre == $0.genre {
                let timePartsOfDuration = $0.duration.toTimeParts()
                return FileCellUiModel(
                    id: $0.id,
                    title: $0.name,
                    caption: String(format: "%2.fMB - \(timePartsOfDuration.minutes)m \(timePartsOfDuration.seconds)s", $0.size/1000),
                    isInMemory: $0.data != nil
                )
            }
            return nil
        }
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, FileCellUiModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(uiModel, toSection: 0)
        diffableDataSource?.apply(snapshot)
    }
    
    func buttonDidTapped(with id: Int) -> Error? {
        return repository.saveOrDeleteFromMemory(music: id)
    }
}

