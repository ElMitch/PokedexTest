//
//  Data+Extensions.swift
//  PokedexMitch
//
//  Created by Mitchell Samaniego on 28/12/22.
//

import Foundation

extension Data {
    func toLogString(encoding: String.Encoding = .utf8) -> String? {
        var logString: String?
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self)
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                logString = "JSON: \(jsonString)"
            }
        } catch {
            if count < 5000 {
                logString = String(data: self, encoding: encoding)
            }
            if logString == nil {
                logString = "Data (\(count) bytes)"
            }
        }

        return logString
    }

    func toJSON(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        try JSONSerialization.jsonObject(with: self, options: options)
    }
}
