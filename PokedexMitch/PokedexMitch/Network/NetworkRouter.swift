//
//  NetworkRouter.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Foundation
import Moya

enum NetworkRouter: TargetType {
    case getPokemonList
    
    var baseURL: URL {
        URL(string: Environment.getEnvironmentVariable(name: .baseUrl) ?? "")!
    }

    var path: String {
        switch self {
        case .getPokemonList:
            return "pokemon"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPokemonList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let headers: [String: String] = [:]
        return headers
    }
}
