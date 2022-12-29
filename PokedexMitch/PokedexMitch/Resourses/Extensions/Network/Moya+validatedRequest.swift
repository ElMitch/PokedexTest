//
//  Moya+validatedRequest.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Foundation
import Moya

extension MoyaProvider {
    @discardableResult
    func requestValidated(_ target: Target,
                          callbackQueue: DispatchQueue? = .none,
                          progress: ProgressBlock? = .none,
                          completion: @escaping Completion) -> Cancellable {
        request(target, callbackQueue: callbackQueue, progress: progress) { result in
            switch result {
            case let .success(result):
                if let request = result.request {
                    print("🚀 ✅ \(request.httpMethod ?? "") request \(request.url?.absoluteString ?? "")")
                }
                if let jsonData = result.data.toLogString() {
                    print("🚀 \(jsonData)")
                }
                completion(.success(result))
            case let .failure(error):
                if let result = error.response {
                    print("result:  \(result) --- \(result.request)")
                    completion(.success(result))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}


