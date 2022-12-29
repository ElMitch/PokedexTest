//
//  PrincipalViewController.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 27/12/22.
//

import RxSwift
import UIKit

class PrincipalViewController: UIViewController {
    
    // Properties
    private let router = PrincipalViewRouter()
    private let viewModel = PrincipalViewModel()
    
    // UI
    private var collectionView: UICollectionView!
    private lazy var searchController = UISearchController()
    private let emptyView = UIView()
    private let emptyImage = UIImageView()
    private let emptyLabel = UILabel()
    
    // Variables
    private let disposeBag = DisposeBag()
    private var pokemonsList: [PokemonModel] = []
    private var filteredPokemons: [PokemonModel] = []
    private var isHaveNext: Bool = true
    private var isSearchActive: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.bind(view: self, router: router)
        getData()
        manageSearchBarController()
    }

    private func setupView() {
        view.backgroundColor = .black.withAlphaComponent(0.7)
        emptyView.backgroundColor = .black
        setupCollectionView()
        
        view.registerView(emptyView)
        emptyView.registerView(emptyImage)
        emptyView.registerView(emptyLabel)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            emptyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyImage.bottomAnchor.constraint(equalTo: emptyLabel.topAnchor, constant: -12),
            emptyImage.heightAnchor.constraint(equalToConstant: 120),
            emptyImage.widthAnchor.constraint(equalToConstant: 150),

            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 24),
            emptyLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -24)
        ])

        emptyImage.image = UIImage(named: "emptyImage")
        emptyLabel.attributedText = .init(string: "Parece que no hemos podido encontrar resultados. Intenta con otra busqueda", attributes: NSAttributedString.pokemonDetailNumber)
        emptyLabel.numberOfLines = 0
        emptyLabel.textAlignment = .center
        emptyView.isHidden = true
    }

    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.identifier)
        collectionView.backgroundColor = .clear
        view.registerView(collectionView)
    }

    private func getData() {
        return viewModel.getPokemonList(offset: pokemonsList.count)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonList in
                self?.pokemonsList.append(contentsOf: pokemonList.results)
                self?.isHaveNext = pokemonList.next != nil
                self?.reloadCollectionView()
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }

    private func getFilteredData(with search: String) {
        return viewModel.getPokemonFilered(with: search)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonResult in
                self?.filteredPokemons.append(pokemonResult)
                self?.reloadCollectionView()
                self?.emptyView.isHidden = true
            } onError: { [weak self] errorResult in
                self?.emptyView.isHidden = false
                print(errorResult.localizedDescription)
            }.disposed(by: disposeBag)
    }

    private func getForType(with type: Int) {
        
    }

    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    private func manageSearchBarController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.barStyle = .black
        searchController.searchBar.placeholder = "Buscar un pokemon por nombre o ID"
    }
}

extension PrincipalViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = (isSearchActive ? filteredPokemons[indexPath.row].id : indexPath.row + 1) ?? 1
        router.navigateToDetailView(sending: id)
    }
}

extension PrincipalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isSearchActive ? filteredPokemons.count : pokemonsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as! PokemonCell
        let id = (isSearchActive ? filteredPokemons[indexPath.row].id : indexPath.row + 1) ?? 1
        cell.setInfo(with: isSearchActive ? filteredPokemons[indexPath.row] : pokemonsList[indexPath.row], id)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (isSearchActive ? filteredPokemons.count : pokemonsList.count) - 4,
            isHaveNext {
            getData()
        }
    }
}

extension PrincipalViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 10
        return CGSize(width: width, height: 210)
    }
}

extension PrincipalViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = true
        guard let text = searchBar.text else { return }
        getFilteredData(with: text.lowercased())
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
        collectionView.reloadData()
    }
}
