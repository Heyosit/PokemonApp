//
//  Sprites.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 02/08/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import Foundation

struct Sprites: Codable {
    
    let backDefaultImageUrl: String?
    let backFemaleImageUrl: String?
    let backShinyImageUrl: String?
    let backShinyFemaleImageUrl: String?
    let frontDefaultImageUrl: String?
    let frontFemaleImageUrl: String?
    let frontShinyImageUrl: String?
    let frontShinyFemaleImageUrl: String?
    
    var frontImageURLs = [String]()
    
    enum CodingKeys: String, CodingKey {
        case backDefaultImageUrl = "back_default"
        case backFemaleImageUrl = "back_female"
        case backShinyImageUrl = "back_shiny"
        case backShinyFemaleImageUrl = "back_shiny_female"
        case frontDefaultImageUrl = "front_default"
        case frontFemaleImageUrl = "front_female"
        case frontShinyImageUrl = "front_shiny"
        case frontShinyFemaleImageUrl = "front_shiny_female"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.backDefaultImageUrl = try values.decodeIfPresent(String.self, forKey: .backDefaultImageUrl)
        self.backFemaleImageUrl = try values.decodeIfPresent(String.self, forKey: .backFemaleImageUrl)
        self.backShinyImageUrl = try values.decodeIfPresent(String.self, forKey: .backShinyImageUrl)
        self.backShinyFemaleImageUrl = try values.decodeIfPresent(String.self, forKey: .backShinyFemaleImageUrl)
        self.frontDefaultImageUrl = try values.decodeIfPresent(String.self, forKey: .frontDefaultImageUrl)
        self.frontFemaleImageUrl = try values.decodeIfPresent(String.self, forKey: .frontFemaleImageUrl)
        self.frontShinyImageUrl = try values.decodeIfPresent(String.self, forKey: .frontShinyImageUrl)
        self.frontShinyFemaleImageUrl = try values.decodeIfPresent(String.self, forKey: .frontShinyFemaleImageUrl)
        setupFrontImageURLs()
    }
    
    private mutating func setupFrontImageURLs() {
        if let image = frontDefaultImageUrl {
            frontImageURLs.append(image)
        }
        
        if let image = frontFemaleImageUrl {
            frontImageURLs.append(image)
        }
        
        if let image = frontShinyImageUrl {
            frontImageURLs.append(image)
        }
        
        if let image = frontShinyFemaleImageUrl {
            frontImageURLs.append(image)
        }
    }
}

