//
//  TextStyles.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import UIKit

public extension NSAttributedString {
    static var pokemonName: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 16),
        .foregroundColor: UIColor.black
    ]

    static var pokemonNumber: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.gray
    ]
}
