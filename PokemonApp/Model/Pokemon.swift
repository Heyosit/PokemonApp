//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 31/07/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

struct Pokemon: Codable {
    let abilities: [Abilities]?
    let baseExperience: Int?
    let height: Int?
    let id: Int?
    let moves: [Moves]?
    let name: String?
    let sprites: Sprites?
    let stats: [Stats]?
    let types: [Types]?
    let weight: Int?
    
    var imageList: [UIImage]?
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case height
        case id
        case moves
        case name
        case sprites
        case stats
        case types
        case weight
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.abilities = try values.decodeIfPresent([Abilities].self, forKey: .abilities)
        self.baseExperience = try values.decodeIfPresent(Int.self, forKey: .baseExperience)
        self.height = try values.decodeIfPresent(Int.self, forKey: .height)
        self.id = try values.decodeIfPresent(Int.self, forKey: .id)
        self.moves = try values.decodeIfPresent([Moves].self, forKey: .moves)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.sprites = try values.decodeIfPresent(Sprites.self, forKey: .sprites)
        self.stats = try values.decodeIfPresent([Stats].self, forKey: .stats)
        self.types = try values.decodeIfPresent([Types].self, forKey: .types)
        self.weight = try values.decodeIfPresent(Int.self, forKey: .weight)
        
    }
}
