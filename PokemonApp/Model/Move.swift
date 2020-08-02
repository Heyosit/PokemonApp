//
//  Move.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 02/08/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import Foundation

typealias Move = NameUrlModel

struct Moves: Codable {
    var move: Move?
    
    enum CodingKeys: String, CodingKey {
        case move
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.move = try values.decodeIfPresent(Move.self, forKey: .move)
    }
}
