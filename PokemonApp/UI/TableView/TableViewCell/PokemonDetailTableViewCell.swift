//
//  PokemonSummaryTableViewCell.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 29/07/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

final class PokemonSummaryTableViewCell: UITableViewCell {
    
    //MARK: - UI
    
    private var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.Common.lightBlue
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        return containerView
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.Common.orange
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: PokemonSummaryTableViewCell.idLabelFontSize, weight: .bold)
        return label
    }()
        
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = UIColor.Common.orange
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: PokemonSummaryTableViewCell.nameLabelFontSize, weight: .semibold)
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupCellProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        containerView.addSubview(idLabel)
        containerView.addSubview(nameLabel)
        
        self.addSubview(containerView)
                
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 10),
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 5),
            
            idLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            idLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),

            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20),
            
        ])
    }
    
    private func setupCellProperties() {
        self.backgroundColor = UIColor.Common.darkGray
        self.selectionStyle = .none
    }
    
    //MARK: - Config
    
    func config(pokemon: PokemonSummary) {
        nameLabel.text = pokemon.name?.capitalized
        if let id = pokemon.id {
            idLabel.text = "\(id))"
        }
    }
}

//MARK: Constants

extension PokemonSummaryTableViewCell {
    
    static var leadingLabelSpacing: CGFloat = 15
    static var topBottomLabelSpacing: CGFloat = 5
    static var nameLabelFontSize: CGFloat = 22
    static var idLabelFontSize: CGFloat = 30
}
