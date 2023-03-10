//
//  PrincipalViewPresenter.swift
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

protocol PrincipalViewPresentationInterface {
    func presentPokemonList(response: PrincipalViewModels.FetchPokemonList.Response)
    func presentPokemonFiltered(response: PrincipalViewModels.FetchFilteredPokemonList.Response)
    func presentPokemonsOfType(response: PrincipalViewModels.FetchPokemonType.Response)
}

class PrincipalViewPresenter: PrincipalViewPresentationInterface {
    weak var viewController: PrincipalViewDisplayInterface?

    // MARK: Do something

    func presentPokemonList(response: PrincipalViewModels.FetchPokemonList.Response) {
        let viewModel = PrincipalViewModels.FetchPokemonList.ViewModel(pokemonList: response.pokemonList?.results, isHaveNext: response.pokemonList?.next != nil, errorMessage: response.error?.localizedDescription)
        viewController?.displayPokemonList(viewModel: viewModel)
    }

    func presentPokemonFiltered(response: PrincipalViewModels.FetchFilteredPokemonList.Response) {
        let viewModel = PrincipalViewModels.FetchFilteredPokemonList.ViewModel(pokemon: response.pokemon, errorMessage: response.error?.localizedDescription)
        viewController?.displayPokemonFiltered(viewModel: viewModel)
    }

    func presentPokemonsOfType(response: PrincipalViewModels.FetchPokemonType.Response) {
        var viewModel = PrincipalViewModels.FetchPokemonType.ViewModel()
        viewModel.errorMessage = response.error?.localizedDescription
        if let pokemons = response.pokemons {
            viewModel.pokemons = getPokemons(of: pokemons)
        }
        viewController?.displayPokemonsForType(viewModel: viewModel)
    }

    private func getPokemons(of list: PokemonsForType) -> [PokemonModel] {
        let pokemonList: [PokemonModel] = list.pokemon.map { pokemonResult -> PokemonModel in
            return PokemonModel(name: pokemonResult.pokemon.name, id: Int(pokemonResult.pokemon.url?.getIDOfURLForType() ?? "0"), url: pokemonResult.pokemon.url)
        }
        return pokemonList
    }
}
