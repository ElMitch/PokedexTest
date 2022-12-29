//
//  PokemonModel.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Foundation

struct PokemonList: Codable, Hashable {
    let count: Int
    let next: String?
    let results: [PokemonModel]
}

struct PokemonModel: Codable, Hashable {
    let name: String
    let id: Int?
}
