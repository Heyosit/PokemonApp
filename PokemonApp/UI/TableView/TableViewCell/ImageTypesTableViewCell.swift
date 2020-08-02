//
//  ImageTypesTableViewCell.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 02/08/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

final class ImageTypesTableViewCell: UITableViewCell {
    
    private lazy var pokemonImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = ImageTypesTableViewCell.imageViewCornerRadius
        imageView.layer.masksToBounds = true
        let image = UIImage(named: ImageTypesTableViewCell.imagePlaceholderName)
        imageView.image = image
        return imageView
    }()
    
    private lazy var typesView: TypesView = {
        let view = TypesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var imageTypesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = ImageTypesTableViewCell.stackViewInternalSpacing
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        imageTypesStackView.addArrangedSubview(pokemonImageView)
        imageTypesStackView.addArrangedSubview(typesView)
        
        addSubview(imageTypesStackView)
        
        imageTypesStackView.anchor(to: self, constant: ImageTypesTableViewCell.stackViewSpacing)
        
        NSLayoutConstraint.activate([
            pokemonImageView.heightAnchor.constraint(lessThanOrEqualToConstant: ImageTypesTableViewCell.imageViewHeightWidth),
            pokemonImageView.widthAnchor.constraint(lessThanOrEqualToConstant: ImageTypesTableViewCell.imageViewHeightWidth),
        ])
    }
    
    private func setupProperties() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func config(image: UIImage? = nil, types: [Types]? = nil) {
        if let image = image {
            pokemonImageView.image = image
        }
        typesView.config(types: types)
    }
}

//MARK: Constants

extension ImageTypesTableViewCell {
    
    static var imageViewCornerRadius: CGFloat = 20
    static var imagePlaceholderName: String = "pok_silhouette.png"
    static var imageViewHeightWidth: CGFloat = 100
    static var stackViewInternalSpacing: CGFloat = 10
    static var stackViewSpacing: CGFloat = 10
}
