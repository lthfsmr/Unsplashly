//
//  SearchPhotoRequest.swift
//  Common
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Foundation

public struct SearchPhotosRequest: Codable {
  public var query: String?
  public var page: Int?
  public var perPage: Int?
  public var orderBy: OrderBy?
  public var collections: String?
  public var contentFilter: ContentFilter?
  public var color: ColorFilter?
  public var orientation: Orientation?
  
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

public enum OrderBy: String, Codable {
  case latest
  case relevant
}

public enum ContentFilter: String, Codable {
  case low
  case high
}

public enum ColorFilter: String, Codable {
  case black_and_white, black, white, yellow, orange, red, purple, magenta, green, teal, blue
}

public enum Orientation: String, Codable {
  case landscape
  case portrait
  case squarish
}

public extension SearchPhotosRequest {
    init(query: String? = "", page: Int? = 1) {
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
