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

    static let shared = NetworkManagerService()
    let provider: MoyaProvider<NetworkRouter>

    init() {
        provider = .init()
    }

    func getPokemons() -> Observable<[PokemonModel]> {
        return Observable.create { observer in
            self.provider.request(.getPokemonList) { result in
                switch result {
                case let .success(response):
                    do {
                        let userData = try JSONDecoder().decode(PokemonList.self, from: response.data)
                        observer.onNext(userData.results)
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
                self.provider.cancelCompletion({ result in
                    print(result)
                }, target: .getPokemonList)
            }
        }
    }
}
