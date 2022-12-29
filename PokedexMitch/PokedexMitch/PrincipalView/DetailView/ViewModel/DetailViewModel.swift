//
//  DetailViewModel.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 29/12/22.
//

import Foundation
import RxSwift

class DetailViewModel {
    private var view: DetailViewController?
    private var router: DetailViewRouter?
    private var managerConnections = NetworkManagerService()

    func bind(view: DetailViewController, router: DetailViewRouter) {
        self.view = view
        self.router = router

        self.router?.setSourceView(view)
    }

    func getPokemonDetail(of number: Int) -> Observable<PokemonDetailModel> {
        return managerConnections.getDetailOfPokemon(of: number)
    }
}

