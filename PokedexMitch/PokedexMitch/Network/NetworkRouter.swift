//
//  NetworkRouter.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Foundation
import Moya

enum NetworkRouter: TargetType {
    case getPokemonList(offset: Int)
    case pokemonDetail(number: Int)
    case getFilteredPokemon(search: String)
    case getPokemonsForType(type: String)
    
    var baseURL: URL {
        URL(string: Environment.getEnvironmentVariable(name: .baseUrl) ?? "")!
    }

    var path: String {
        switch self {
        case .getPokemonList:
            return "pokemon"
        case let .pokemonDetail(number):
            return "pokemon/\(number)/"
        case let .getFilteredPokemon(search):
            return "pokemon/\(search)/"
        case let .getPokemonsForType(type):
            return "type/\(type)/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPokemonList, .pokemonDetail, .getFilteredPokemon, .getPokemonsForType:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .getPokemonList(offset):
            return .requestParameters(parameters: ["offset": offset], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let headers: [String: String] = [:]
        return headers
    }
}
