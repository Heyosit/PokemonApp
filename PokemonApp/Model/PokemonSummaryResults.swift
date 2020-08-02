//
//  PokemonSummary.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 30/07/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import Foundation

typealias PokemonSummary = NameUrlModel

struct PokemonSummaryResults: Decodable {
    var count: Int?
    var next: String?
    var results: [PokemonSummary]?
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case results
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try values.decodeIfPresent(Int.self, forKey: .count)
        self.next = try values.decodeIfPresent(String.self, forKey: .next)
        self.results = try values.decodeIfPresent([PokemonSummary].self, forKey: .results)
    }
}

