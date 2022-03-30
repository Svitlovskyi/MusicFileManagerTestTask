//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import UIKit


public class CollectionViewCell: UITableViewCell {
    public var diffableDataSource: UICollectionViewDiffableDataSource<Int, DetailLargeCellUiModel>!
    public var collectionView: UICollectionView = {
        let collectionFlow = UICollectionViewFlowLayout()
        collectionFlow.scrollDirection = .horizontal
        collectionFlow.itemSize = CGSize(
            width: UIScreen.main.bounds.width*0.4,
            height: UIScreen.main.bounds.width*0.6

        )
        collectionFlow.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlow)
        collectionView.register(MusicLargeCell.self, forCellWithReuseIdentifier: ReusableIdentifiers.collectionViewCell)
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    public func configure(with model: CollectionViewCellUiModel) {
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let tile = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReusableIdentifiers.collectionViewCell,
                for: indexPath
            ) as? MusicLargeCell else { return UICollectionViewCell() }
            tile.configure(with: itemIdentifier)
            return tile
        }
        ///I know, why thats bad, and how to improve, btw.
        var snapshot = NSDiffableDataSourceSnapshot<Int, DetailLargeCellUiModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(model.content, toSection: 0)
        diffableDataSource.apply(snapshot)
    }
}
