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
    private var imageOfPokemon = UIImageView()
    private var numberOfPokemon = UILabel()
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
        
        containerView.registerView(imageOfPokemon)

        let textStackView = UIStackView(arrangedSubviews: [numberOfPokemon, nameOfPokemon])
        textStackView.axis = .vertical
        textStackView.distribution = .fillProportionally
        textStackView.alignment = .fill
        textStackView.spacing = 0

        containerView.registerView(textStackView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            imageOfPokemon.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageOfPokemon.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageOfPokemon.heightAnchor.constraint(equalToConstant: 140),
            imageOfPokemon.widthAnchor.constraint(equalToConstant: 140),

            textStackView.topAnchor.constraint(equalTo: imageOfPokemon.bottomAnchor, constant: 10),
            textStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            textStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        imageOfPokemon.layer.cornerRadius = 70
        imageOfPokemon.layer.shadowColor = UIColor.mainYellow.cgColor
        imageOfPokemon.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        imageOfPokemon.layer.shadowOpacity = 1
        imageOfPokemon.layer.shadowRadius = 5
        imageOfPokemon.clipsToBounds = false

        nameOfPokemon.textAlignment = .center
    }

    func setInfo(with pokemon: PokemonModel, _ number: Int) {
        imageOfPokemon.backgroundColor = .cyan
        nameOfPokemon.attributedText = .init(string: pokemon.name, attributes: NSAttributedString.pokemonName)
        numberOfPokemon.attributedText = .init(string: "N°\(number)", attributes: NSAttributedString.pokemonNumber)
    }
}
