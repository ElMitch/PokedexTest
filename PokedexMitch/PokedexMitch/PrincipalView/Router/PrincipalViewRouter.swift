//
//  PrincipalViewRouter.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Foundation
import UIKit

class PrincipalViewRouter {
    var viewController: UIViewController {
        return createViewController()
    }

    private var sourceView: UIViewController?

    private func createViewController() -> UIViewController {
        let view = PrincipalViewController()
        return view
    }

    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("error desconocido") }
        self.sourceView = view
    }

    func navigateToDetailView(sending pokemonID: Int) {
        let detailView = DetailViewRouter(pokemonID: pokemonID).viewController
        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }
}
