//
//  DetailPokemonModel.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Foundation

struct PokemonDetailModel: Codable, Hashable {
    let name: String
    let id: Int
    let types: [TypesListModel]
    let stats: [StatsListModel]
}

struct TypesListModel: Codable, Hashable {
    let slot: Int
    let type: TypeModel
}

struct TypeModel: Codable, Hashable {
    let name: TypeEnum
}

enum TypeEnum: String, Codable {
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

    init(from decoder: Decoder) throws {
        do {
            let statValue = try decoder.singleValueContainer().decode(String.self)
            switch statValue {
            case "normal":
                self = .normal
            case "fighting":
                self = .fighting
            case "flying":
                self = .flying
            case "poison":
                self = .poison
            case "ground":
                self = .ground
            case "rock":
                self = .rock
            case "bug":
                self = .bug
            case "ghost":
                self = .ghost
            case "steel":
                self = .steel
            case "fire":
                self = .fire
            case "water":
                self = .water
            case "grass":
                self = .grass
            case "electric":
                self = .electric
            case "psychic":
                self = .psychic
            case "ice":
                self = .ice
            case "dragon":
                self = .dragon
            case "dark":
                self = .dark
            case "fairy":
                self = .fairy
            case "shadow":
                self = .shadow
            default:
                self = .unknown
            }
        }
    }
}

struct StatsListModel: Codable, Hashable {
    let baseStat: Int
    let stat: StatsModel

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct StatsModel: Codable, Hashable {
    let name: StatsEnum
}

enum StatsEnum: String, Codable {
    case hp
    case attack
    case defense
    case specialAttack
    case specialDefense
    case speed
    case accuracy // Precision
    case evasion
    case unknown

    init(from decoder: Decoder) throws {
        do {
            let statValue = try decoder.singleValueContainer().decode(String.self)
            switch statValue {
            case "hp":
                self = .hp
            case "attack":
                self = .attack
            case "defense":
                self = .defense
            case "special-attack":
                self = .specialAttack
            case "special-defense":
                self = .specialDefense
            case "speed":
                self = .speed
            case "accuracy":
                self = .accuracy
            case "evasion":
                self = .evasion
            default:
                self = .unknown
            }
        }
    }
}
