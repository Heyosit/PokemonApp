//
//  ViewController.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 28/07/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {
    
    private var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        getPokemon()
    }
    
//    private func getPokemon() -> Pokemon {
//        PokeApiManager().fetchPokemon { [weak self] (pokemon) in
//          self?.pokemon = pokemon
//          DispatchQueue.main.async {
////            self?.tableView.reloadData()
//          }
//        }
//    }


}

