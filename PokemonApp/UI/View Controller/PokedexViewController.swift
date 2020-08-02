//
//  PokedexViewController.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 28/07/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {
    
    //MARK: - UI
    
    private var pokemonListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = UIView(frame: CGRect(x: .zero, y: .zero, width: .zero, height: CGFloat.leastNormalMagnitude))
        
        return tableView
    }()
    
    // MARK: - Properties
    
    private var pokemonSummaryList = [PokemonSummary]()
    private var pokemonSummaryResults: PokemonSummaryResults?
    
    // MARK: Setup
    
    override func loadView() {
        super.loadView()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(pokemonListTableView)
        
        pokemonListTableView.anchor(to: self.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupPokemonSummaryResults()
        
    }
    
    private func setup() {
        setupTableView()
        setupNavigationController()
    }
    
    private func setupTableView() {
        pokemonListTableView.backgroundColor = UIColor.Common.darkGray
        pokemonListTableView.delegate = self
        pokemonListTableView.dataSource = self
        pokemonListTableView.register(PokemonSummaryTableViewCell.self, forCellReuseIdentifier: PokemonSummaryTableViewCell.reuseIdentifier)
        
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = UIColor.Common.lightBlue
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Pokedex"
    }
    
    private func setupPokemonSummaryResults() {
        guard let _ = pokemonSummaryResults else {
            getPokemons()
            return
        }
    }
    
    //MARK: - API
    
    private func getPokemons(withPath path: String? = nil) {
        PokeApi.shared.fetchPokemonSummary(withPath: path, completion:  { (pokemonSummaryResults) in
            DispatchQueue.main.async {
                self.pokemonSummaryResults = pokemonSummaryResults
                guard let pokemonSummaries = pokemonSummaryResults?.results else { return }
                self.pokemonSummaryList += pokemonSummaries
                self.pokemonListTableView.reloadData()
            }
        })
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PokedexViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonSummaryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonSummaryTableViewCell.reuseIdentifier, for: indexPath) as! PokemonSummaryTableViewCell
        cell.config(pokemon: pokemonSummaryList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            if let nextPath = pokemonSummaryResults?.next {
                getPokemons(withPath: nextPath)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonDetailVC = PokemonDetailViewController()
        pokemonDetailVC.modalPresentationStyle = .fullScreen
        pokemonDetailVC.pokemonId = pokemonSummaryList[indexPath.row].id
        self.show(pokemonDetailVC, sender: nil)
        
    }
}


