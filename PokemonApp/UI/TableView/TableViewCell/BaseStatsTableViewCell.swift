//
//  BaseStatsTableViewCell.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 02/08/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

final class BaseStatsTableViewCell: UITableViewCell {
    
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
        label.font = UIFont.systemFont(ofSize: BaseStatsTableViewCell.titleFontSize, weight: .bold)
        label.text = "Base Stats:"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = BaseStatsTableViewCell.collectionViewCellLayoutSize
        layout.sectionInset = BaseStatsTableViewCell.collectionViewCellLayoutInset
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bounces = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    //MARK: - Properties
    
    var stats: [Stats]? { didSet { didUpdateStats() } }
    private var statsList = [(name: String, value: Int)]()
    
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
            hairlineView.heightAnchor.constraint(equalToConstant: BaseStatsTableViewCell.hairlineTopSpacing),
            hairlineView.topAnchor.constraint(equalTo: self.topAnchor),
            hairlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: BaseStatsTableViewCell.hairlineSideSpacing),
            self.trailingAnchor.constraint(equalTo: hairlineView.trailingAnchor, constant: BaseStatsTableViewCell.hairlineSideSpacing),

            titleLabel.topAnchor.constraint(equalTo: hairlineView.bottomAnchor, constant: BaseStatsTableViewCell.titleTopBottomSpacing),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: BaseStatsTableViewCell.titleSideSpacing),
            self.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: BaseStatsTableViewCell.titleSideSpacing),
            
            collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: BaseStatsTableViewCell.collectionViewHeight),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: BaseStatsTableViewCell.titleTopBottomSpacing),
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
    
    private func didUpdateStats() {
        guard let stats = stats else { return }
        var baseStat: (name: String, value: Int)
        statsList.removeAll()
        for stat in stats {
            guard let value = stat.baseStat, let name = stat.stat?.name else { return }
            baseStat.value = value
            baseStat.name = name
            statsList.append(baseStat)
        }
        collectionView.reloadData()
    }
    
    //MARK: - Configuration
    
    func config(stats: [Stats]?) {
        guard let stats = stats else { return }
        self.stats = stats
        
    }
}

//MARK: - UICollectionViewDelegate

extension BaseStatsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return statsList.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleDescriptionCollectionViewCell.reuseIdentifier, for: indexPath) as! TitleDescriptionCollectionViewCell
        cell.config(title: statsList[indexPath.row].name, description: "\(statsList[indexPath.row].value)")
        return cell
    }
    
}

//MARK: Constants

extension BaseStatsTableViewCell {
    
    static var titleFontSize: CGFloat = 20
    static var collectionViewCellLayoutSize = CGSize(width: 160, height: 30)
    static var collectionViewCellLayoutInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    static var hairlineTopSpacing: CGFloat = 2
    static var hairlineSideSpacing: CGFloat = 10
    static var titleTopBottomSpacing: CGFloat = 8
    static var titleSideSpacing: CGFloat = 10
    static var collectionViewHeight: CGFloat = 100
    
}
