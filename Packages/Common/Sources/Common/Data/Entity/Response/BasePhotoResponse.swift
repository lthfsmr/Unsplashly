//
//  BasePhotoResponse.swift
//  Common
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Foundation

// MARK: - SearchPhotos
public struct BasePhotoResponse: Codable {
    public let total: Int?
    public let totalPages: Int?
    public let results: [Photo]?

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
