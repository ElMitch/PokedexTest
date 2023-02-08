//
//  PrincipalViewWorker.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 07/02/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PrincipalViewInterface {
    func fetchPokemonListData(request: PrincipalViewModels.FetchPokemonList.Request, completion: @escaping (Result<PokemonList, Error>) -> Void)
    func fetchFilteredPokemonList(request: PrincipalViewModels.FetchFilteredPokemonList.Request, completion: @escaping (Result<PokemonModel, Error>) -> Void)
    func fetchPokemonsForType(request: PrincipalViewModels.FetchPokemonType.Request, completion: @escaping (Result<PokemonsForType, Error>) -> Void)
}

class PrincipalViewWorker: PrincipalViewInterface {
    func fetchPokemonListData(request: PrincipalViewModels.FetchPokemonList.Request, completion: @escaping (Result<PokemonList, Error>) -> Void) {
        NetworkManagerService.shared.getPokemons(offset: request.count) { result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchFilteredPokemonList(request: PrincipalViewModels.FetchFilteredPokemonList.Request, completion: @escaping (Result<PokemonModel, Error>) -> Void) {
        NetworkManagerService.shared.getFilteredPokemon(with: request.textToSearch) { result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchPokemonsForType(request: PrincipalViewModels.FetchPokemonType.Request, completion: @escaping (Result<PokemonsForType, Error>) -> Void) {
        NetworkManagerService.shared.getPokemonsForType(with: request.type) { result in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}