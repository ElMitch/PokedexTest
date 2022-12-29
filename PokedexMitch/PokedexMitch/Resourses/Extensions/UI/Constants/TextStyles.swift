//
//  TextStyles.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import UIKit

public extension NSAttributedString {
    static var pokemonListName: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 16),
        .foregroundColor: UIColor.white
    ]

    static var pokemonListNumber: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.white
    ]

    static var pokemonDetailName: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 24),
        .foregroundColor: UIColor.white
    ]

    static var pokemonDetailNumber: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 16),
        .foregroundColor: UIColor.white
    ]
}
