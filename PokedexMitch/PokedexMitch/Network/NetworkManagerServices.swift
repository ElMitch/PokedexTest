//
//  NetworkManagerServices.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Foundation
import Moya
import RxSwift

final class NetworkManagerService {
    // MARK: - Typealias

    typealias Closure<T> = (Result<T, Error>) -> Void

    // MARK: - Properties
    let provider: MoyaProvider<NetworkRouter>

    init() {
        provider = .init()
    }

    func getPokemons(offset: Int) -> Observable<PokemonList> {
        return Observable.create { observer in
            self.provider.requestValidated(.getPokemonList(offset: offset)) { result in
                switch result {
                case let .success(response):
                    do {
                        let listData = try JSONDecoder().decode(PokemonList.self, from: response.data)
                        observer.onNext(listData)
                    } catch let error {
                        observer.onError(error)
                    }
                case let .failure(error):
                    print("Error request: \(error.errorDescription ?? "")")
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create {
                print("Se completo la carga de la lista")
            }
        }
    }

    func getDetailOfPokemon(of number: Int) -> Observable<PokemonDetailModel> {
        return Observable.create { observer in
            self.provider.requestValidated(.pokemonDetail(number: number)) { result in
                switch result {
                case let .success(response):
                    do {
                        let detailData = try JSONDecoder().decode(PokemonDetailModel.self, from: response.data)
                        observer.onNext(detailData)
                    } catch let error {
                        observer.onError(error)
                    }
                case let .failure(error):
                    print("Error request: \(error.errorDescription ?? "")")
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create {
                print("Se completo la obtencion del detalle")
            }
        }
    }

    func getFilteredPokemon(with search: String) -> Observable<PokemonModel> {
        return Observable.create { observer in
            self.provider.requestValidated(.getFilteredPokemon(search: search)) { result in
                switch result {
                case let .success(response):
                    do {
                        let detailData = try JSONDecoder().decode(PokemonModel.self, from: response.data)
                        observer.onNext(detailData)
                    } catch let error {
                        observer.onError(error)
                    }
                case let .failure(error):
                    print("Error request: \(error.errorDescription ?? "")")
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create {
                print("Se completo la obtencion del detalle")
            }
        }
    }

    func getPokemonsForType(with type: String) -> Observable<PokemonsForType> {
        return Observable.create { observer in
            self.provider.requestValidated(.getPokemonsForType(type: type)) { result in
                switch result {
                case let .success(response):
                    do {
                        let detailData = try JSONDecoder().decode(PokemonsForType.self, from: response.data)
                        observer.onNext(detailData)
                    } catch let error {
                        observer.onError(error)
                    }
                case let .failure(error):
                    print("Error request: \(error.errorDescription ?? "")")
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create {
                print("Se completo la obtencion de la lista de types")
            }
        }
    }
}
