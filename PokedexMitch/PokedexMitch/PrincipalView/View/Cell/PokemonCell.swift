//
//  PokemonCell.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    static let identifier = "PokemonCell_identifier"

    private var containerView = UIView()
    private var imageBackground = UIView()
    private var imageOfPokemon = UIImageView()
    private var nameOfPokemon = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        contentView.registerView(containerView)
        
        containerView.registerView(imageBackground)
        imageBackground.registerView(imageOfPokemon)
        containerView.registerView(nameOfPokemon)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            imageBackground.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            imageBackground.heightAnchor.constraint(equalToConstant: 120),
            imageBackground.widthAnchor.constraint(equalToConstant: 120),
            imageBackground.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            imageOfPokemon.centerYAnchor.constraint(equalTo: imageBackground.centerYAnchor),
            imageOfPokemon.centerXAnchor.constraint(equalTo: imageBackground.centerXAnchor),
            imageOfPokemon.heightAnchor.constraint(equalToConstant: 100),
            imageOfPokemon.widthAnchor.constraint(equalToConstant: 100),

            nameOfPokemon.topAnchor.constraint(equalTo: imageBackground.bottomAnchor),
            nameOfPokemon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            nameOfPokemon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            nameOfPokemon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        imageOfPokemon.setShadow()

        nameOfPokemon.textAlignment = .center

        containerView.layer.borderColor = UIColor.mainRed.cgColor
        containerView.layer.borderWidth = 1.0
        containerView.layer.cornerRadius = 10

        imageBackground.backgroundColor = .mainBlue.withAlphaComponent(0.3)
        imageBackground.layer.cornerRadius = 60

        nameOfPokemon.numberOfLines = 0
    }

    func setInfo(with pokemon: PokemonModel, _ number: Int) {
        imageOfPokemon.setPrincipalImage(of: number)
        nameOfPokemon.attributedText = .init(string: pokemon.name.capitalized, attributes: NSAttributedString.pokemonListName)
    }
}
