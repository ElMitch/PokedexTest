//
//  View+registerView.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import UIKit

extension UIView {
    func registerView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}
