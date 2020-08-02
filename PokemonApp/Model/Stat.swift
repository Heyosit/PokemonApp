//
//  Stat.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 02/08/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import Foundation

typealias Stat = NameUrlModel

struct Stats: Codable {
    var baseStat: Int?
    var effort: Int?
    var stat: Stat?
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.baseStat = try values.decodeIfPresent(Int.self, forKey: .baseStat)
        self.effort = try values.decodeIfPresent(Int.self, forKey: .effort)
        self.stat = try values.decodeIfPresent(Stat.self, forKey: .stat)
    }
}


