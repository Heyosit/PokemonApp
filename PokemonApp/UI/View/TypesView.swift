//
//  TypesView.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 02/08/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

final class TypesView: UIView {
    
    //MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor.Common.orange
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var primaryTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor.Common.orange
        return label
    }()
    
    private lazy var secondaryTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor.Common.orange
        return label
    }()
    
    private lazy var typesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupProperties()
    }
    
    private func setupLayout() {
        typesStackView.addArrangedSubview(primaryTypeLabel)
        typesStackView.addArrangedSubview(secondaryTypeLabel)
        
        addSubview(titleLabel)
        addSubview(typesStackView)
        
        NSLayoutConstraint.activate([            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            typesStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            typesStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            typesStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            typesStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
    
    private func setupProperties() {
        self.backgroundColor = .clear
        titleLabel.text = "Types:"
        primaryTypeLabel.text = "Not Defined"
        secondaryTypeLabel.text = ""
    }
    
    //MARK: - Configuration
    
    func config(types: [Types]?) {
        guard let types = types else { return }
        let labels: [UILabel] = [primaryTypeLabel, secondaryTypeLabel]
        
        for (index, type) in types.enumerated() {
            guard index < labels.count else {
                return
            }
            if let typeName = type.type?.name {
                labels[index].text = typeName.capitalized
            }
        }
        
    }
}
