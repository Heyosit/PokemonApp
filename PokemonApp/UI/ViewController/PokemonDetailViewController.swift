//
//  PokemonDetailViewController.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 31/07/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

final class PokemonDetailViewController: UIViewController {
    
    //MARK: - UI
    
    private var pokemonDetailTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = true
        tableView.tableHeaderView = UIView(frame: CGRect(x: .zero, y: .zero, width: .zero, height: CGFloat.leastNormalMagnitude))
        return tableView
    }()
    
    //MARK: - Properties
    
    enum Row {
        case imageType
        case baseStats
        case abilities
    }
    
    var pokemonId: Int? { didSet { getPokemonInfo() } }
    private var pokemon: Pokemon? { didSet { didUpdatePokemon() } }
    private var rows: [Row] = [.imageType, .baseStats, .abilities]
    
    override func loadView() {
        super.loadView()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(pokemonDetailTableView)
        
        pokemonDetailTableView.anchor(to: view, constant: 8)
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = UIColor.Common.lightBlue
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = UIColor.Common.darkGray
        setupNavigationController()
        setupTableView()
    }
    
    private func setupTableView() {
        pokemonDetailTableView.backgroundColor = UIColor.Common.lightBlue
        pokemonDetailTableView.layer.cornerRadius = 10
        pokemonDetailTableView.layer.masksToBounds = true
        pokemonDetailTableView.delegate = self
        pokemonDetailTableView.dataSource = self
        pokemonDetailTableView.separatorStyle = .none
        pokemonDetailTableView.register(ImageTypesTableViewCell.self, forCellReuseIdentifier: ImageTypesTableViewCell.reuseIdentifier)
        pokemonDetailTableView.register(BaseStatsTableViewCell.self, forCellReuseIdentifier: BaseStatsTableViewCell.reuseIdentifier)
        pokemonDetailTableView.register(AbilitiesTableViewCell.self, forCellReuseIdentifier: AbilitiesTableViewCell.reuseIdentifier)
        
    }
    
    private func didUpdatePokemon() {
        guard let pokemon = pokemon else { return }
        self.navigationItem.title = pokemon.name?.capitalized
    }
    
    //MARK: - API
    
    private func getPokemonInfo() {
        guard let id = pokemonId else { return }
        PokeApi.shared.fetchPokemonById(id: id, completion: { (pokemonResult) in
            DispatchQueue.main.async {
                self.pokemon = pokemonResult
                self.getPokemonImages()
                self.pokemonDetailTableView.reloadData()
            }
        })
    }
    
    private func getPokemonImages() {
        guard let sprites = pokemon?.sprites, !sprites.frontImageURLs.isEmpty else { return }
        PokeApi.shared.fetchImages(for: sprites, completion: { (imageList) in
            DispatchQueue.main.async {
                if !imageList.isEmpty {
                    self.pokemon?.imageList = imageList
                    self.pokemonDetailTableView.reloadData()
                }
            }
        })
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let element = rows[indexPath.row]
        switch element {
        case .imageType:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageTypesTableViewCell.reuseIdentifier, for: indexPath) as! ImageTypesTableViewCell
            cell.config(image: pokemon?.imageList?.first, types: pokemon?.types)
            
            return cell
        case .baseStats:
            let cell = tableView.dequeueReusableCell(withIdentifier: BaseStatsTableViewCell.reuseIdentifier, for: indexPath) as! BaseStatsTableViewCell
            cell.config(stats: pokemon?.stats)
            
            return cell
        case .abilities:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AbilitiesTableViewCell.reuseIdentifier, for: indexPath) as! AbilitiesTableViewCell
            cell.config(abilities: pokemon?.abilities)
            
            return cell
        }
    }
}
