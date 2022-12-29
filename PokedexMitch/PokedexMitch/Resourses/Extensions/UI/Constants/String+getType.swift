//
//  String+getType.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 29/12/22.
//

import Foundation

extension String {
    func getTypeOfURL() -> String {
        let urlWithOnlyNumber = self.replacingOccurrences(of: "https://pokeapi.co/api/v2/type/", with: "")
        let onlyNumber = urlWithOnlyNumber.replacingOccurrences(of: "/", with: "")
        return onlyNumber
    }

    func getIDOfURLForType() -> String {
        let urlWithOnlyNumber = self.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon/", with: "")
        let onlyNumber = urlWithOnlyNumber.replacingOccurrences(of: "/", with: "")
        return onlyNumber
    }
}
