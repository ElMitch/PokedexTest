//
//  Environment.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Foundation
import UIKit

struct Environment {
    enum VariableNames: String {
        case baseUrl = "API_BASE_URL"

        private static let infoPlist: [String: Any] = {
            guard let dict = Bundle.main.infoDictionary else {
                fatalError("Plist file not found")
            }
            return dict
        }()
    }

    static func getEnvironmentVariable(name: VariableNames) -> String? {
        guard let environmentDictionary = Bundle.main.infoDictionary else { fatalError("Dont access to Info Dictionary") }
        let variable = environmentDictionary[name.rawValue] as? String

        return variable
    }
}

