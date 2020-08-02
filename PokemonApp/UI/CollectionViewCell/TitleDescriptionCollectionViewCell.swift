//
//  TitleDescriptionCollectionViewCell.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 02/08/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

final class TitleDescriptionCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor.Common.orange
        label.font = UIFont.systemFont(ofSize: TitleDescriptionCollectionViewCell.titleFontSize, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor.Common.orange
        label.font = UIFont.systemFont(ofSize: TitleDescriptionCollectionViewCell.descriptionFontSize, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //MARK: - Properties
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupCellProperties()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            

            descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
    
    private func setupCellProperties() {
        self.backgroundColor = .clear
    }
    
    func config(title: String, description: String? = nil) {
        titleLabel.text = title.capitalized
        if let description = description {
            descriptionLabel.isHidden = false
            descriptionLabel.text = description
            titleLabel.text = title.capitalized + ": "
        }
        else {
            descriptionLabel.isHidden = true
        }
    }
}

//MARK: Constants

extension TitleDescriptionCollectionViewCell {
    
    static var titleFontSize: CGFloat = 16
    static var descriptionFontSize: CGFloat = 16
}
