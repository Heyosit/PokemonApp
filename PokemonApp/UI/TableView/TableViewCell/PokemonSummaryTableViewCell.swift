//
//  PokemonDetailTableViewCell.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 01/08/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

final class PokemonDetailTableViewCell: UITableViewCell {
    
    private var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.Common.lightBlue
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        return containerView
    }()
        
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.Common.orange
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: PokemonDetailTableViewCell.nameLabelFontSize, weight: .bold)
        return label
    }()
    
    private lazy var thumbnailImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    static var reuseIdentifier: String {
      return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupCellProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        containerView.addSubview(thumbnailImageView)
        containerView.addSubview(nameLabel)
        
        self.addSubview(containerView)
                
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 10),
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 5),
            
//            thumbnailImageView.heightAnchor.constraint(equalToConstant: 40),
//            thumbnailImageView.widthAnchor.constraint(equalToConstant: 40),
            thumbnailImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            thumbnailImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),

            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
        ])
    }
    
    private func setupCellProperties() {
        self.backgroundColor = UIColor.Common.darkGray
        self.selectionStyle = .none
    }
    
    func config(pokemon: PokemonSummary) {
        nameLabel.text = pokemon.results?[0].name?.capitalized
    }
}

//MARK: Constants

extension PokemonDetailTableViewCell {
    
    static var leadingLabelSpacing: CGFloat = 15
    static var topBottomLabelSpacing: CGFloat = 5
    static var nameLabelFontSize: CGFloat = 16
}
