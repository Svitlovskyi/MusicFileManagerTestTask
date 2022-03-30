//
//  DashboardViewModel.swift
//  MusicFileManagerApp
//
//  Created by Maksym Svitlovskyi on 23.03.2022.
//

import UIComponents
import UIKit
import BusinessLogicLayer

class DashboardViewModel: DashboardViewModelProtocol {
    var diffableDataSource: DashboardTableViewDataSource?
    var snapshot: NSDiffableDataSourceSnapshot<DashboardSectionUiModel, DashboardCellUiModel>?
    
    var uiModel: DashboardUiModel = DashboardUiModel(sections: [])
    let repository: MusicRepository
    
    init(repository: MusicRepository) {
        self.repository = repository
        createUiModel()
    }
    
    func trailingCollectionButtonDidTapped(with id: UUID) {
        guard let section = snapshot?.sectionIdentifiers.first(where: { $0.id == id }) else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.coordinator?.moveToSeeAll(
            with: DetailListViewModel(repository: repository, for: section.title)
        )
    }
    
    func applySnapshot() {
        snapshot = NSDiffableDataSourceSnapshot<DashboardSectionUiModel, DashboardCellUiModel>()
        snapshot?.appendSections(uiModel.sections)
        uiModel.sections.enumerated().forEach { (index, item) in
            snapshot?.appendItems(item.content, toSection: item)
        }
        if let snapshot = snapshot {
            diffableDataSource?.apply(snapshot)
        }
    }
    
    func createUiModel() {
        let groupedByGenres = Dictionary(grouping: repository.musics, by: { $0.genre })
        groupedByGenres.keys.forEach { key in
            uiModel.sections.append(
                DashboardSectionUiModel(
                    id: UUID(),
                    title: key,
                    trailingButtonTitle: "See all", /// Use Localizable.string, SwiftGen (or sth) for generate keys
                    content: [
                        .detailedCollection(
                            model: CollectionViewCellUiModel(
                                content: groupedByGenres[key]!.prefix(5).map(transformMusicToDetailLargeCellUiModel(_:))
                            )
                        )
                    ]
                )
            )
        }
        uiModel.sections.append(memorySection)
    }
    
    lazy var memorySection: DashboardSectionUiModel = {
        return DashboardSectionUiModel(
            id: UUID(),
            title: "Memory",
            trailingButtonTitle: "",
            content: getMemorySectionContent()
        )
    }()

    func getMemorySectionContent() -> [DashboardCellUiModel] {
        let filesystemMemoryDuration = repository.musics.filter { $0.data == nil }.map { return $0.duration }.reduce(0, +)
        let inMemoryDuration = repository.musics.filter { $0.data != nil }.map { return $0.duration }.reduce(0, +)
        return [
            .simple(
                model: SimpleRowUiModel(
                    id: UUID(), title: "Memory",
                    trailingItem: String(filesystemMemoryDuration.toTimeParts().minutes))),
            .simple(
                model: SimpleRowUiModel(
                    id: UUID(),
                    title: "Filesystem",
                    trailingItem: String(inMemoryDuration.toTimeParts().minutes)))
        ]
    }
    
    func viewWillAppear() {
        updateMemorySection()
    }
    
    func updateMemorySection() {
        snapshot?.deleteItems(memorySection.content)
        memorySection.content = getMemorySectionContent()
        snapshot?.appendItems(memorySection.content)
        
        self.diffableDataSource?.apply(snapshot!, animatingDifferences: false)
    }
        
    func transformMusicToDetailLargeCellUiModel(_ music: Music) -> DetailLargeCellUiModel {
        let title = "\(music.name) - \(music.author)"
        let durationString: String = {
            let timeParts = music.duration.toTimeParts()
            return "\(timeParts.minutes)m \(timeParts.seconds)s"
        }()
        return DetailLargeCellUiModel(
            id: music.id,
            image: music.image ?? UIImage(systemName: "circle.fill")!,
            title: title,
            leadingCaption: String(format: "%.2f MB", music.size/1000),
            trailingCaption: durationString
        )
    }
}

