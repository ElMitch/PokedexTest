//
//  DetailViewController.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 29/12/22.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {

    // Properties
    private let router: DetailViewRouter
    private let viewModel = DetailViewModel()

    // UI
    private let backgroundImage = UIImageView()
    private let scrollView = UIScrollView()
    private let nameLabel = UILabel()
    private let numberLabel = UILabel()
    private let principalImage = UIImageView()
    private let shinyImage = UIImageView()
    private let typesTitle = UILabel()
    private let firstContainer = UIView()
    private let firstType = UILabel()
    private let secondContainer = UIView()
    private let secondType = UILabel()
    private let statsTitle = UILabel()
    private let statsStackView = UIStackView()

    // Variables
    private let estimatedWidth = DetailViewController.mainWidth.estimatedWidthForImages()
    private let pokemonID: Int
    private let disposeBag = DisposeBag()
    private var pokemonDetail: PokemonDetailModel?

    init(pokemonID: Int) {
        self.pokemonID = pokemonID
        router = DetailViewRouter(pokemonID: pokemonID)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.bind(view: self, router: router)
        getData()
    }

    private func setupView() {
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .black.withAlphaComponent(0.7)
        view.registerView(backgroundImage)
        view.registerView(scrollView)

        let nameAndNumberStack = UIStackView(arrangedSubviews: [nameLabel, numberLabel])
        nameAndNumberStack.axis = .vertical
        nameAndNumberStack.distribution = .fill
        nameAndNumberStack.spacing = 12
        nameAndNumberStack.alignment = .fill
        scrollView.registerView(nameAndNumberStack)

        let imagesStackView = UIStackView(arrangedSubviews: [principalImage, shinyImage])
        imagesStackView.axis = .horizontal
        imagesStackView.distribution = .fillEqually
        imagesStackView.alignment = .fill
        imagesStackView.spacing = 12
        scrollView.registerView(imagesStackView)

        scrollView.registerView(typesTitle)
        scrollView.registerView(firstContainer)
        secondContainer.registerView(firstType)
        scrollView.registerView(secondContainer)
        secondContainer.registerView(secondType)
        scrollView.registerView(statsTitle)
        scrollView.registerView(statsStackView)

        statsStackView.axis = .vertical
        statsStackView.distribution = .fill
        statsStackView.spacing = 10
        statsStackView.alignment = .fill

        let contentG = scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            nameAndNumberStack.topAnchor.constraint(equalTo: contentG.topAnchor, constant: 12),
            nameAndNumberStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameAndNumberStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            imagesStackView.topAnchor.constraint(equalTo: nameAndNumberStack.bottomAnchor, constant: 24),
            imagesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            imagesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            principalImage.heightAnchor.constraint(equalToConstant: estimatedWidth),
            shinyImage.heightAnchor.constraint(equalToConstant: estimatedWidth),

            typesTitle.topAnchor.constraint(equalTo: imagesStackView.bottomAnchor, constant: 24),
            typesTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            typesTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            firstContainer.topAnchor.constraint(equalTo: typesTitle.bottomAnchor, constant: 12),
            firstContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            firstType.topAnchor.constraint(equalTo: firstContainer.topAnchor, constant: 8),
            firstType.leadingAnchor.constraint(equalTo: firstContainer.leadingAnchor, constant: 8),
            firstType.trailingAnchor.constraint(equalTo: firstContainer.trailingAnchor, constant: -8),
            firstType.bottomAnchor.constraint(equalTo: firstContainer.bottomAnchor, constant: -8),

            secondContainer.topAnchor.constraint(equalTo: typesTitle.bottomAnchor, constant: 12),
            secondContainer.leadingAnchor.constraint(equalTo: firstContainer.trailingAnchor, constant: 8),

            secondType.topAnchor.constraint(equalTo: secondContainer.topAnchor, constant: 8),
            secondType.leadingAnchor.constraint(equalTo: secondContainer.leadingAnchor, constant: 8),
            secondType.trailingAnchor.constraint(equalTo: secondContainer.trailingAnchor, constant: -8),
            secondType.bottomAnchor.constraint(equalTo: secondContainer.bottomAnchor, constant: -8),

            statsTitle.topAnchor.constraint(equalTo: firstContainer.bottomAnchor, constant: 24),
            statsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            statsTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            statsStackView.topAnchor.constraint(equalTo: statsTitle.bottomAnchor, constant: 12),
            statsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            statsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            statsStackView.bottomAnchor.constraint(equalTo: contentG.bottomAnchor, constant: -24)
        ])

        backgroundImage.image = UIImage(named: "detailScreen")
        backgroundImage.contentMode = .scaleAspectFill

        principalImage.layer.cornerRadius = estimatedWidth / 2
        shinyImage.layer.cornerRadius = estimatedWidth / 2

        principalImage.backgroundColor = .mainBlue.withAlphaComponent(0.3)
        shinyImage.backgroundColor = .mainBlue.withAlphaComponent(0.3)

        firstContainer.layer.cornerRadius = 10
        secondContainer.layer.cornerRadius = 10

        typesTitle.attributedText = .init(string: "Tipo", attributes: NSAttributedString.pokemonDetailName)

        statsTitle.attributedText = .init(string: "Stats", attributes: NSAttributedString.pokemonDetailName)
    }

    private func setInfo() {
        guard let detail = pokemonDetail else { return }
        nameLabel.attributedText = .init(string: detail.name.capitalized, attributes: NSAttributedString.pokemonDetailName)
        numberLabel.attributedText = .init(string: "N.°\(detail.id)", attributes: NSAttributedString.pokemonDetailNumber)

        principalImage.setPrincipalImage(of: detail.id)
        shinyImage.setShinyImage(of: detail.id)

        detail.types.forEach { type in
            if type.slot == 1 {
                firstType.attributedText = .init(string: type.type.name.rawValue.capitalized, attributes: NSAttributedString.pokemonDetailNumber)
                firstContainer.setBackgroundOfType(type.type.name)
                firstType.setTextColorOfType(type.type.name)
                principalImage.setBackgroundWithAlphaOfType(type.type.name, alpha: 0.4)
                shinyImage.setBackgroundWithAlphaOfType(type.type.name, alpha: 0.4)
            } else {
                secondType.attributedText = .init(string: type.type.name.rawValue.capitalized, attributes: NSAttributedString.pokemonDetailNumber)
                secondType.setTextColorOfType(type.type.name)
                secondContainer.setBackgroundOfType(type.type.name)
                shinyImage.setBackgroundWithAlphaOfType(type.type.name, alpha: 0.4)
            }
        }

        detail.stats.forEach { stat in
            let label = UILabel()
            label.attributedText = .init(string: "\(stat.stat.name.rawValue.capitalized): \(stat.baseStat)", attributes: NSAttributedString.pokemonDetailNumber)
            statsStackView.addArrangedSubview(label)
        }
    }

    private func getData() {
        return viewModel.getPokemonDetail(of: pokemonID)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonDetailResponse in
                self?.pokemonDetail = pokemonDetailResponse
                self?.setInfo()
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}
