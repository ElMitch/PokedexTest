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
    private let buttonView = UIView()
    private let cleanButton = UIButton()
    private var collectionView: UICollectionView!
    private lazy var searchController = UISearchController()
    private let containerTypesView = UIView()
    private var containerTypesViewHeightContraint: NSLayoutConstraint!
    private let tableViewForTypes = UITableView()

    //// Empty View
    private let emptyView = UIView()
    private let emptyImage = UIImageView()
    private let emptyLabel = UILabel()
    
    // Variables
    private let disposeBag = DisposeBag()
    private var pokemonsList: [PokemonModel] = []
    private var filteredPokemons: [PokemonModel] = []
    private var isHaveNext: Bool = true
    private var isSearchActive: Bool = false
    private var isShowTypes: Bool = false
    
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
        setupCollectionAndTable()

        buttonView.registerView(cleanButton)

        let principalStackView = UIStackView(arrangedSubviews: [containerTypesView, buttonView, collectionView])
        principalStackView.axis = .vertical
        principalStackView.distribution = .fill
        principalStackView.spacing = 10
        principalStackView.alignment = .fill

        view.registerView(principalStackView)

        containerTypesView.registerView(tableViewForTypes)
        
        view.registerView(emptyView)
        emptyView.registerView(emptyImage)
        emptyView.registerView(emptyLabel)

        containerTypesViewHeightContraint = containerTypesView.heightAnchor.constraint(equalToConstant: 0)
        containerTypesViewHeightContraint.isActive = true
        
        NSLayoutConstraint.activate([
            principalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            principalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            principalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            principalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            tableViewForTypes.topAnchor.constraint(equalTo: containerTypesView.topAnchor, constant: 12),
            tableViewForTypes.leadingAnchor.constraint(equalTo: containerTypesView.leadingAnchor, constant: 24),
            tableViewForTypes.trailingAnchor.constraint(equalTo: containerTypesView.trailingAnchor, constant: -24),
            tableViewForTypes.bottomAnchor.constraint(equalTo: containerTypesView.bottomAnchor, constant: -12),

            cleanButton.heightAnchor.constraint(equalToConstant: 30),
            cleanButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -24),
            cleanButton.topAnchor.constraint(equalTo: buttonView.topAnchor),
            cleanButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
            
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
        
        //Observer Notification
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: Notification.Name(NotificationKeys().typeOfPokemonNotification), object: nil)

        // Set Button To Clean
        buttonView.isHidden = true
        cleanButton.addTarget(self, action: #selector(cleanSearchOrFiltered), for: .touchUpInside)
        cleanButton.setAttributedTitle(.init(string: "Limpiar", attributes: NSAttributedString.pokemonDetailNumber), for: .normal)

        // Set Button To Search For Type
        let barButton = UIBarButtonItem(title: "Buscar por Tipo", style: .done, target: self, action: #selector(searchForType))
        navigationItem.rightBarButtonItem = barButton
    }
    
    // Set Components

    private func setupCollectionAndTable() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.identifier)
        collectionView.backgroundColor = .clear

        tableViewForTypes.separatorStyle = .none
        tableViewForTypes.delegate = self
        tableViewForTypes.dataSource = self
        tableViewForTypes.backgroundColor = .clear
    }

    private func manageSearchBarController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barStyle = .black
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.sizeToFit()
        searchController.searchBar.isTranslucent = true

        navigationController?.navigationBar.isTranslucent = true

        // Add searchController to navigation bar
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Buscar un pokemon por nombre o ID"
    
    }

    // Get Info
    
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
            .subscribe { [weak self] pokemonsResult in
                self?.filteredPokemons.append(pokemonsResult)
                self?.reloadCollectionView()
                self?.emptyView.isHidden = true
            } onError: { [weak self] errorResult in
                self?.emptyView.isHidden = false
                print(errorResult.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func getForType(with type: String) {
        return viewModel.getPokemonsForType(with: type)
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] pokemonResult in
                guard let self = self else { return }
                let pokemonForType: [PokemonModel] = self.getPokemons(of: pokemonResult)
                self.filteredPokemons.append(contentsOf: pokemonForType)
                self.reloadCollectionView()
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                self.buttonView.isHidden = false
                self.emptyView.isHidden = true
            } onError: { [weak self] errorResult in
                self?.emptyView.isHidden = false
                print(errorResult.localizedDescription)
            }.disposed(by: disposeBag)
    }

    // Helpers
    
    @objc private func handleNotification(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary?,
           let type = dict["type"] as? String {
            isSearchActive = true
            navigationItem.rightBarButtonItem?.isHidden = true
            filteredPokemons.removeAll()
            searchForType()
            searchController.searchBar.isHidden = true
            getForType(with: type)
        }
    }

    @objc private func cleanSearchOrFiltered() {
        isSearchActive = false
        searchController.searchBar.isHidden = false
        navigationItem.rightBarButtonItem?.isHidden = false
        filteredPokemons.removeAll()
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        buttonView.isHidden = true
    }

    @objc private func searchForType() {
        if !isSearchActive {
            isShowTypes.toggle()
        } else {
            isShowTypes = false
        }
        
        searchController.searchBar.isHidden = isShowTypes
        UIView.animate(withDuration: 1) {
            self.containerTypesViewHeightContraint.constant = self.isShowTypes ? 200 : 0
            self.view.layoutIfNeeded()
        }
    }

    private func getPokemons(of list: PokemonsForType) -> [PokemonModel] {
        let pokemonList: [PokemonModel] = list.pokemon.map { pokemonResult -> PokemonModel in
            return PokemonModel(name: pokemonResult.pokemon.name, id: Int(pokemonResult.pokemon.url?.getIDOfURLForType() ?? "0"), url: pokemonResult.pokemon.url)
        }
        return pokemonList
    }

    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension PrincipalViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = true
        guard let text = searchBar.text else { return }
        filteredPokemons.removeAll()
        getFilteredData(with: text.lowercased())
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
        filteredPokemons.removeAll()
        collectionView.reloadData()
        emptyView.isHidden = true
    }
}

extension PrincipalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TypeCells.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.attributedText = .init(string: TypeCells(rawValue: indexPath.row)?.typeString.capitalized ?? "", attributes: NSAttributedString.pokemonDetailNumber)
        cell.preservesSuperviewLayoutMargins = false
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isSearchActive = true
        searchForType()
        searchController.searchBar.isHidden = true
        filteredPokemons.removeAll()
        getForType(with: "\(indexPath.row + 1)")
    }
}

extension PrincipalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = (isSearchActive ? filteredPokemons[indexPath.row].id : indexPath.row + 1) ?? 1
        router.navigateToDetailView(sending: id)
    }

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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 10
        return CGSize(width: width, height: 210)
    }
}
