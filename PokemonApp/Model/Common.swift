//
//  Common.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 02/08/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import Foundation

struct NameUrlModel: Codable {
    var name: String?
    var url: String?
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
            case name
            case url
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.url = try values.decodeIfPresent(String.self, forKey: .url)
        self.id = getId()
    }
    
    private func getId() -> Int? {
        let stringArray = url!.components(separatedBy: CharacterSet.decimalDigits.inverted)
        var id: Int?
        for item in stringArray {
            if let number = Int(item) {
                id = number
            }
        }
        return id
    }
}
