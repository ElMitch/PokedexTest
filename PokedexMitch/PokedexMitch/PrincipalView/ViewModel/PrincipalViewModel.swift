//
//  PrincipalViewModel.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Foundation

class PrincipalViewModel {
    private var view: PrincipalView?
    private var router: PrincipalRouter?
    private var managerConnections: NetworkManagerService?

    func bind(view: PrincipalView, router: PrincipalRouter) {
        self.view = view
        self.router = router

        self.router?.setSourceView(view)
    }
}
