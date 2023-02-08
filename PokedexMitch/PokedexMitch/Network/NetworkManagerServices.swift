//
//  NetworkManagerServices.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Foundation
import Moya

final class NetworkManagerService {
    // MARK: - Typealias

    typealias Closure<T> = (Result<T, Error>) -> Void

    // MARK: - Properties
    let provider: MoyaProvider<NetworkRouter>
    static let shared = NetworkManagerService()

    init() {
        provider = .init()
    }

    func getPokemons(offset: Int, completion: @escaping Closure<PokemonList>) {
        self.provider.requestValidated(.getPokemonList(offset: offset)) { result in
            switch result {
            case let .success(response):
                do {
                    let listData = try JSONDecoder().decode(PokemonList.self, from: response.data)
                    completion(.success(listData))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                print("Error request: \(error.errorDescription ?? "")")
                completion(.failure(error))
            }
        }
    }

    func getDetailOfPokemon(of number: Int, completion: @escaping Closure<PokemonDetailModel>) {
        self.provider.requestValidated(.pokemonDetail(number: number)) { result in
            switch result {
            case let .success(response):
                do {
                    let detailData = try JSONDecoder().decode(PokemonDetailModel.self, from: response.data)
                    completion(.success(detailData))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                print("Error request: \(error.errorDescription ?? "")")
                completion(.failure(error))
            }
        }
    }

    func getFilteredPokemon(with search: String, completion: @escaping Closure<PokemonModel>) {
        self.provider.requestValidated(.getFilteredPokemon(search: search)) { result in
            switch result {
            case let .success(response):
                do {
                    let detailData = try JSONDecoder().decode(PokemonModel.self, from: response.data)
                    completion(.success(detailData))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                print("Error request: \(error.errorDescription ?? "")")
                completion(.failure(error))
            }
        }
    }

    func getPokemonsForType(with type: String, completion: @escaping Closure<PokemonsForType>) {
        self.provider.requestValidated(.getPokemonsForType(type: type)) { result in
            switch result {
            case let .success(response):
                do {
                    let detailData = try JSONDecoder().decode(PokemonsForType.self, from: response.data)
                    completion(.success(detailData))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                print("Error request: \(error.errorDescription ?? "")")
                completion(.failure(error))
            }
        }
    }
}
