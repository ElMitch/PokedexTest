//
//  UILabel+background.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 29/12/22.
//

import UIKit

extension UILabel {
    func setTextColorOfType(_ type: TypeEnum) {
        switch type {
        case .normal:
            self.textColor = .black
        case .flying:
            self.textColor = .black
        case .ground:
            self.textColor = .black
        case .steel:
            self.textColor = .black
        case .grass:
            self.textColor = .black
        case .electric:
            self.textColor = .black
        case .ice:
            self.textColor = .black
        case .fairy:
            self.textColor = .black
        default:
            break
        }
    }
}
