//
//  Ability.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 02/08/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import Foundation

typealias Ability = NameUrlModel

struct Abilities: Codable {
    var ability: Ability?
    var isHidden: Bool?
    var slot: Int?
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.ability = try values.decodeIfPresent(Ability.self, forKey: .ability)
        self.isHidden = try values.decodeIfPresent(Bool.self, forKey: .isHidden)
        self.slot = try values.decodeIfPresent(Int.self, forKey: .slot)
    }
}

