//
//  File.swift
//  
//
//  Created by Maksym Svitlovskyi on 21.03.2022.
//

import UIKit


public class HeaderWithButtonView: UIView {
    public lazy var title: UILabel = {
        let label = UILabel()
        label.font = AppFonts.headline
        return label
    }()
    
    public lazy var button: UIButton = {
        let configuration = UIButton.Configuration.filled()
        let button = UIButton(configuration: configuration)
        button.titleLabel?.font = AppFonts.body
        button.backgroundColor = AppColors.accentColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    public lazy var contentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, button])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 5, leading: 20, bottom: 5, trailing: 20
        )
        return stackView
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        backgroundColor = .systemBackground
    }
    
    public func configure(with title: String, buttonTitle: String, buttonAction: @escaping () -> Void) {
        self.title.text = title
        if buttonTitle.isEmpty {
            self.button.isHidden = true
        } else {
            self.button.setTitle(buttonTitle, for: .normal)
        }
        self.button.addAction(buttonAction)
    }
}

