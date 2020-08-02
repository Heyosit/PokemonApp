//
//  Type.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 02/08/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import Foundation

typealias Type = NameUrlModel

struct Types: Codable {
    var type: Type?
    var slot: Int?
    
    enum CodingKeys: String, CodingKey {
        case type
        case slot
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try values.decodeIfPresent(Type.self, forKey: .type)
        self.slot = try values.decodeIfPresent(Int.self, forKey: .slot)
    }
}
