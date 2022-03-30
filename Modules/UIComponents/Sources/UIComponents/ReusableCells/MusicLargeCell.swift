//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import UIKit


public class MusicLargeCell: UICollectionViewCell {
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public lazy var title: UILabel = {
        let label = UILabel()
        label.font = AppFonts.body
        label.numberOfLines = 2
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    public lazy var leadingCaption: UILabel = {
        let label = UILabel()
        label.font = AppFonts.caption
        return label
    }()
    
    public lazy var trailingCaption: UILabel = {
        let label = UILabel()
        label.font = AppFonts.caption
        label.textAlignment = .right
        return label
    }()
    
    public lazy var captionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leadingCaption, trailingCaption])
        return stack
    }()
    
    public lazy var cellStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, title, captionStack])
        stack.axis = .vertical

        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 5, leading: 5, bottom: 5, trailing: 5
        )
        return stack
    }()
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        addSubview(cellStack)
        NSLayoutConstraint.activate([
            cellStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellStack.topAnchor.constraint(equalTo: topAnchor),
            cellStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: cellStack.widthAnchor)
        ])
        
        layer.borderWidth = 1
        layer.borderColor = AppColors.secondaryColor.cgColor
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    func configure(with model: DetailLargeCellUiModel) {
        imageView.image = model.image
        title.text = model.title
        leadingCaption.text = model.leadingCaption
        trailingCaption.text = model.trailingCaption
    }
}
