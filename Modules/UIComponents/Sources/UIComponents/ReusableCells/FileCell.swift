//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import UIKit


public class FileCell: UITableViewCell {
    public lazy var title: UILabel = {
        let label = UILabel()
        label.font = AppFonts.body
        return label
    }()
    
    public lazy var caption: UILabel = {
        let label = UILabel()
        label.font = AppFonts.caption
        return label
    }()
    
    public lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImages.cloudCheckmark, for: .normal)
        button.contentHorizontalAlignment = .trailing
        button.isSelected = false
        return button
    }()
    
    public lazy var cellStack: UIStackView = {
        let textStack = UIStackView(arrangedSubviews: [title, caption])
        textStack.axis = .vertical
        let cellStack = UIStackView(arrangedSubviews: [textStack, saveButton])
        cellStack.translatesAutoresizingMaskIntoConstraints = false
        cellStack.distribution = .fillProportionally
        cellStack.isLayoutMarginsRelativeArrangement = true
        cellStack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0, leading: 20, bottom: 0, trailing: 20
        )
        return cellStack
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(cellStack)
        NSLayoutConstraint.activate([
            cellStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellStack.topAnchor.constraint(equalTo: topAnchor),
            cellStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure(with model: FileCellUiModel, buttonAction: @escaping () -> Error?) {
        self.title.text = model.title
        self.caption.text = model.caption
        self.saveButton.setImage(
            model.isInMemory ? AppImages.cloudCheckmark : AppImages.cloudArrowDown,
            for: .normal
        )
        saveButton.addAction { [weak self] in
            guard let self = self else { return }
            if let error = buttonAction() {
                //TODO: Display error using alert etc.
                print(error.localizedDescription)
                return
            }
            self.saveButton.isSelected.toggle()
            self.saveButton.setImage(
                self.saveButton.isSelected ? AppImages.cloudCheckmark : AppImages.cloudArrowDown,
                for: .normal
            )
        }
    }
}
