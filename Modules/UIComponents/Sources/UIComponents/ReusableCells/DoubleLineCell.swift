//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import UIKit


public class DoubleLineCell: UITableView {
    public lazy var title: UILabel = {
        let label = UILabel()
        label.font = AppFonts.body
        return label
    }()
    public lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = AppFonts.caption
        return label
    }()
    
    public lazy var cellContent: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            title, subtitle
        ])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        addSubview(cellContent)
        NSLayoutConstraint.activate([
            cellContent.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellContent.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellContent.topAnchor.constraint(equalTo: topAnchor),
            cellContent.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    public func configure(with model: DoubleLineCellUiModel) {
        title.text = model.title
        subtitle.text = model.subtitle
    }
}
