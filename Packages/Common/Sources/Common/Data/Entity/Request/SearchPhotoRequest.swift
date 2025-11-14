//
//  SearchPhotoRequest.swift
//  Common
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Foundation

public struct SearchPhotosRequest: Codable {
  let query: String?
  let page: Int?
  let perPage: Int?
  let orderBy: OrderBy?
  let collections: String?
  let contentFilter: ContentFilter?
  let color: ColorFilter?
  let orientation: Orientation?
  
  enum CodingKeys: String, CodingKey {
    case query
    case page
    case perPage = "per_page"
    case orderBy = "order_by"
    case collections
    case contentFilter = "content_filter"
    case color
    case orientation
  }
}

enum OrderBy: String, Codable {
  case latest
  case relevant
}

enum ContentFilter: String, Codable {
  case low
  case high
}

enum ColorFilter: String, Codable {
  case black_and_white, black, white, yellow, orange, red, purple, magenta, green, teal, blue
}

enum Orientation: String, Codable {
  case landscape
  case portrait
  case squarish
}

public extension SearchPhotosRequest {
    init(query: String? = "random", page: Int?) {
        self.query = query
        self.page = page
        self.perPage = nil
        self.orderBy = nil
        self.collections = nil
        self.contentFilter = nil
        self.color = nil
        self.orientation = nil
    }
}
