//
//  PrincipalRouter.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Foundation
import UIKit

class PrincipalRouter {
    var viewController: UIViewController {
        return createViewController()
    }

    private var sourceView: UIViewController?

    private func createViewController() -> UIViewController {
        let view = PrincipalView()
        return view
    }

    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else { fatalError("error desconocido") }
        self.sourceView = view
    }

    func navigateToDetailView() {}
}
