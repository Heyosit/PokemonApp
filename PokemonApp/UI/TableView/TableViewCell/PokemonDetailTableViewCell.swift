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
        containerView.layer.cornerRadius = PokemonSummaryTableViewCell.containerViewCornerRadius
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
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: PokemonSummaryTableViewCell.containerViewHeight),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: PokemonSummaryTableViewCell.containerViewTopBottomSpacing),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: PokemonSummaryTableViewCell.containerViewSideSpacing),
            trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: PokemonSummaryTableViewCell.containerViewSideSpacing),
            bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: PokemonSummaryTableViewCell.containerViewTopBottomSpacing),
            
            idLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            idLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: PokemonSummaryTableViewCell.labelSideSpacing),

            nameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: PokemonSummaryTableViewCell.labelSideSpacing),
            containerView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: PokemonSummaryTableViewCell.labelSideSpacing),
            
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
    
    static var containerViewCornerRadius: CGFloat = 20
    static var containerViewHeight: CGFloat = 40
    static var containerViewTopBottomSpacing: CGFloat = 5
    static var containerViewSideSpacing: CGFloat = 10
    static var nameLabelFontSize: CGFloat = 22
    static var idLabelFontSize: CGFloat = 30
    static var labelSideSpacing: CGFloat = 20
}
