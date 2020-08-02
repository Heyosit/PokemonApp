//
//  AbilitiesTableViewCell.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 02/08/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

final class AbilitiesTableViewCell: UITableViewCell {
    
    //MARK: - UI
    
    private lazy var hairlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Common.darkGray
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = UIColor.Common.orange
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Abilities"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 120, height: 30)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bounces = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    //MARK: - Properties
    
    var abilities: [Abilities]? { didSet { didUpdateAbilities() } }
    private var abilityList = [String]()
    
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
        addSubview(hairlineView)
        addSubview(titleLabel)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            hairlineView.heightAnchor.constraint(equalToConstant: 2),
            hairlineView.topAnchor.constraint(equalTo: self.topAnchor),
            hairlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.trailingAnchor.constraint(equalTo: hairlineView.trailingAnchor, constant: 10),

            titleLabel.topAnchor.constraint(equalTo: hairlineView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            
            collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupProperties() {
        selectionStyle = .none
        backgroundColor = .clear
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TitleDescriptionCollectionViewCell.self, forCellWithReuseIdentifier: TitleDescriptionCollectionViewCell.reuseIdentifier)
    }
    
    private func didUpdateAbilities() {
        guard let abilities = abilities else { return }
        abilityList.removeAll()
        for abilty in abilities {
            guard let name = abilty.ability?.name else { return }
            abilityList.append(name)
        }
        collectionView.reloadData()
    }
    
    //MARK: - Configuration
    
    func config(abilities: [Abilities]?) {
        guard let abilities = abilities else { return }
        self.abilities = abilities
        
    }
}

//MARK: - UICollectionViewDelegate

extension AbilitiesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return abilityList.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleDescriptionCollectionViewCell.reuseIdentifier, for: indexPath) as! TitleDescriptionCollectionViewCell
        cell.config(title: abilityList[indexPath.row])
        return cell
    }
    
}

