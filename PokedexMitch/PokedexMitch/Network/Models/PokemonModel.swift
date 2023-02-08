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
    let url: String?
}

struct PokemonsForType: Codable, Hashable {
    let pokemon: [PokemonForType]
}

struct PokemonForType: Codable, Hashable {
    let pokemon: PokemonModel
}

enum TypeCells: Int, CaseIterable {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
    case shadow

    var typeString: String {
        switch self {
        case .normal:
            return "normal"
        case .fighting:
            return "fighting"
        case .flying:
            return "flying"
        case .poison:
            return "poison"
        case .ground:
            return "ground"
        case .rock:
            return "rock"
        case .bug:
            return "bug"
        case .ghost:
            return "ghost"
        case .steel:
            return "steel"
        case .fire:
            return "fire"
        case .water:
            return "water"
        case .grass:
            return "grass"
        case .electric:
            return "electric"
        case .psychic:
            return "psychic"
        case .ice:
            return "ice"
        case .dragon:
            return "dragon"
        case .dark:
            return "dark"
        case .fairy:
            return "fairy"
        case .unknown:
            return "unknown"
        case .shadow:
            return "shadow"
        }
    }
}
