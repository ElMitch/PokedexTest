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

    func setBackgroundOfType(_ type: TypeEnum) {
        switch type {
        case .normal:
            self.backgroundColor = .normalType
        case .fighting:
            self.backgroundColor = .fightingType
        case .flying:
            self.backgroundColor = .flyingType
        case .poison:
            self.backgroundColor = .poisonType
        case .ground:
            self.backgroundColor = .groundType
        case .rock:
            self.backgroundColor = .rockType
        case .bug:
            self.backgroundColor = .bugType
        case .ghost:
            self.backgroundColor = .ghostType
        case .steel:
            self.backgroundColor = .steelType
        case .fire:
            self.backgroundColor = .fireType
        case .water:
            self.backgroundColor = .waterType
        case .grass:
            self.backgroundColor = .grassType
        case .electric:
            self.backgroundColor = .electricType
        case .psychic:
            self.backgroundColor = .psychicType
        case .ice:
            self.backgroundColor = .iceType
        case .dragon:
            self.backgroundColor = .dragonType
        case .dark:
            self.backgroundColor = .darkType
        case .fairy:
            self.backgroundColor = .fairyType
        case .unknown:
            self.backgroundColor = .unknownType
        case .shadow:
            self.backgroundColor = .shadowType
        }
    }

    func setBackgroundWithAlphaOfType(_ type: TypeEnum, alpha: CGFloat) {
        switch type {
        case .normal:
            self.backgroundColor = .normalType.withAlphaComponent(alpha)
        case .fighting:
            self.backgroundColor = .fightingType.withAlphaComponent(alpha)
        case .flying:
            self.backgroundColor = .flyingType.withAlphaComponent(alpha)
        case .poison:
            self.backgroundColor = .poisonType.withAlphaComponent(alpha)
        case .ground:
            self.backgroundColor = .groundType.withAlphaComponent(alpha)
        case .rock:
            self.backgroundColor = .rockType.withAlphaComponent(alpha)
        case .bug:
            self.backgroundColor = .bugType.withAlphaComponent(alpha)
        case .ghost:
            self.backgroundColor = .ghostType.withAlphaComponent(alpha)
        case .steel:
            self.backgroundColor = .steelType.withAlphaComponent(alpha)
        case .fire:
            self.backgroundColor = .fireType.withAlphaComponent(alpha)
        case .water:
            self.backgroundColor = .waterType.withAlphaComponent(alpha)
        case .grass:
            self.backgroundColor = .grassType.withAlphaComponent(alpha)
        case .electric:
            self.backgroundColor = .electricType.withAlphaComponent(alpha)
        case .psychic:
            self.backgroundColor = .psychicType.withAlphaComponent(alpha)
        case .ice:
            self.backgroundColor = .iceType.withAlphaComponent(alpha)
        case .dragon:
            self.backgroundColor = .dragonType.withAlphaComponent(alpha)
        case .dark:
            self.backgroundColor = .darkType.withAlphaComponent(alpha)
        case .fairy:
            self.backgroundColor = .fairyType.withAlphaComponent(alpha)
        case .unknown:
            self.backgroundColor = .unknownType.withAlphaComponent(alpha)
        case .shadow:
            self.backgroundColor = .shadowType.withAlphaComponent(alpha)
        }
    }
}
