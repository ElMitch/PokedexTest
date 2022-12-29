//
//  PrincipalViewModel.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Foundation
import RxSwift

class PrincipalViewModel {
    private var view: PrincipalViewController?
    private var router: PrincipalViewRouter?
    private var managerConnections = NetworkManagerService()

    func bind(view: PrincipalViewController, router: PrincipalViewRouter) {
        self.view = view
        self.router = router

        self.router?.setSourceView(view)
    }

    func getPokemonList(offset: Int) -> Observable<PokemonList> {
        return managerConnections.getPokemons(offset: offset)
    }

    func getPokemonFilered(with search: String) -> Observable<PokemonModel> {
        return managerConnections.getFilteredPokemon(with: search)
    }

    func getPokemonsForType(with type: String) -> Observable<PokemonsForType> {
        return managerConnections.getPokemonsForType(with: type)
    }
}
