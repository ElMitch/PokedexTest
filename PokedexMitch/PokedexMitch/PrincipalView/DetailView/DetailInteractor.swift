//
//  DetailInteractor.swift
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

protocol DetailBusinessInterface {
    func fetchDetailOfPokemon()
}

protocol DetailDataStore {
    var pokemonID: Int? { get set }
}

class DetailInteractor: DetailBusinessInterface, DetailDataStore {
    var presenter: DetailPresentationInterface?
    var worker = DetailWorker()
    var pokemonID: Int?

    // MARK: Do something

    func fetchDetailOfPokemon() {
        let request = Detail.PokemonDetail.Request(id: pokemonID ?? 0)
        var response = Detail.PokemonDetail.Response()

        worker.fetchDetailOfPokemon(request: request) { result in
            switch result {
            case .success(let detailOfPokemon):
                response.detail = detailOfPokemon
            case .failure(let error):
                response.error = error
            }
            self.presenter?.presentDetailOfPokemon(response: response)
        }
    }
}