//
//  ImageCharge.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setPrincipalImage(of number: Int) {
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(number).png")
        self.kf.setImage(with: url)
    }

    func setShinyImage(of number: Int) {
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(number).png")
        self.kf.setImage(with: url)
    }

    func setShadow() {
        self.layer.shadowColor = UIColor.mainYellow.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5
        self.clipsToBounds = false
        self.contentMode = .scaleAspectFill
    }
}
