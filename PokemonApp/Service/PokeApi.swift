//
//  PokeApi.swift
//  PokemonApp
//
//  Created by Alessio Perrotti on 31/07/2020.
//  Copyright © 2020 Alessio Perrotti. All rights reserved.
//

import UIKit

final class PokeApi {
    
    static let shared = PokeApi()
    
    let BASE_URL = "https://pokeapi.co/api/v2/"
    
    func fetchPokemonSummary(withPath newPath: String? = nil, completion: @escaping (PokemonSummaryResults?) -> ()) {
        let path = newPath ?? BASE_URL + ApiPath.fetchPokemonSummary.path()
        
        getResponse(path: path, type: PokemonSummaryResults.self, completion: { (pokemonSummaryResult) in
            completion(pokemonSummaryResult)
        })
    }
    
    func fetchPokemonById(id: Int, completion: @escaping (Pokemon?) -> () ) {
        let path = BASE_URL + ApiPath.fetchPokemonById.path(value: "\(id)")
        
        getResponse(path: path, type: Pokemon.self, completion: { (pokemon) in
            completion(pokemon)
        })
    }
    
    private func getResponse<T:Decodable>(path: String, type: T.Type, completion: @escaping (T?) -> ()) {
        guard let url = URL(string: path) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                print("Failed to fetch data with error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            let decodedResult = try? decoder.decode(T.self, from: data)
            
            completion(decodedResult)
        }.resume()
    }
    
    func fetchImages(for sprites: Sprites, completion: @escaping ([UIImage]) -> ()) {
        var imageListResult = [UIImage]()
        for (index, imageUrl) in sprites.frontImageURLs.enumerated() {
            guard let url = URL(string: imageUrl) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Failed to fetch image with error: ", error.localizedDescription)
                    return
                }
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                imageListResult.append(image)
                if index == sprites.frontImageURLs.count - 1 {
                    completion(imageListResult)
                }
            }.resume()
            
        }
    }
}

extension PokeApi {
    enum ApiPath: String {
        
        case fetchPokemonSummary
        case fetchPokemonById
        
        func path(value: String? = nil) -> String {
            switch self {
            case .fetchPokemonSummary:
                return "pokemon?limit=100&offset=0"
            case .fetchPokemonById:
                return "pokemon/" + (value ?? "0")
            default:
                return ""
            }
        }
    }
}
