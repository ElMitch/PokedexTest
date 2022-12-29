//
//  DetailViewRouter.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 29/12/22.
//

import Foundation
import UIKit

class DetailViewRouter {
    var viewController: UIViewController {
        return createViewController(with: pokemonId)
    }

    private var sourceView: UIViewController?
    private let pokemonId: Int

    init(pokemonID: Int) {
        self.pokemonId = pokemonID
    }

    private func createViewController(with pokemonID: Int?) -> UIViewController {
        guard let pokemonID = pokemonID else { fatalError("No existe ID de Pokemon") }
        let view = DetailViewController(pokemonID: pokemonID)
        return view
    }

    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("error desconocido") }
        self.sourceView = view
    }
}

