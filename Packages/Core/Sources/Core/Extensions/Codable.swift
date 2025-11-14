//
//  Codable.swift
//  Core
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Foundation

public extension Encodable {
  var parameters: [String: Any] {
    guard let data = try? JSONEncoder().encode(self),
          let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
      return [:]
    }

    var result: [String: Any] = [:]

    for (key, value) in dict {
      // Special handling for filters and facets
      if key == "filters" || key == "facets",
         let nested = value as? [String: Any] {
        for (nestedKey, nestedValue) in nested {
          result["\(key)[\(nestedKey)]"] = nestedValue
        }
      } else {
        result[key] = value
      }
    }

    return result
  }
}
