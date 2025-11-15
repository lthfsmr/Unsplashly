//
//  Photo.swift
//  Common
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Foundation

// MARK: - Photo
public struct Photo: Codable, Hashable, Identifiable {
  public let id: String?
  public let createdAt: String?
  public let width: Int?
  public let height: Int?
  public let color: String?
  public let blurHash: String?
  public let likes: Int?
  public let likedByUser: Bool?
  public let description: String?
  public let user: User?
  public let currentUserCollections: [CollectionItem]?
  public let urls: PhotoURLs?
  public let links: PhotoLinks?
  
  enum CodingKeys: String, CodingKey {
    case id
    case createdAt = "created_at"
    case width, height, color
    case blurHash = "blur_hash"
    case likes
    case likedByUser = "liked_by_user"
    case description
    case user
    case currentUserCollections = "current_user_collections"
    case urls, links
  }
}

// MARK: - User
public struct User: Codable, Hashable {
  public let id: String?
  public let username: String?
  public let name: String?
  public let firstName: String?
  public let lastName: String?
  public let instagramUsername: String?
  public let twitterUsername: String?
  public let portfolioURL: String?
  public let profileImage: ProfileImage?
  public let links: UserLinks?
  
  enum CodingKeys: String, CodingKey {
    case id, username, name
    case firstName = "first_name"
    case lastName = "last_name"
    case instagramUsername = "instagram_username"
    case twitterUsername = "twitter_username"
    case portfolioURL = "portfolio_url"
    case profileImage = "profile_image"
    case links
  }
}

// MARK: - ProfileImage
public struct ProfileImage: Codable, Hashable {
  public let small: String?
  public let medium: String?
  public let large: String?
}

// MARK: - PhotoURLs
public struct PhotoURLs: Codable, Hashable {
  public let raw: String?
  public let full: String?
  public let regular: String?
  public let small: String?
  public let thumb: String?
  
  public init(regular: String?, thumb: String?) {
    self.raw = nil
    self.full = nil
    self.regular = regular
    self.small = nil
    self.thumb = thumb
  }
}

// MARK: - PhotoLinks
public struct PhotoLinks: Codable, Hashable {
  public let `self`: String?
  public let html: String?
  public let download: String?
  
  enum CodingKeys: String, CodingKey {
    case `self`
    case html
    case download
  }
}

// MARK: - UserLinks
public struct UserLinks: Codable, Hashable {
  public let `self`: String?
  public let html: String?
  public let photos: String?
  public let likes: String?
  
  enum CodingKeys: String, CodingKey {
    case `self`
    case html
    case photos
    case likes
  }
}

// MARK: - CollectionItem
public struct CollectionItem: Codable, Hashable {
  public let id: Int?
  public let title: String?
  public let publishedAt: String?
  public let lastCollectedAt: String?
  public let updatedAt: String?
  public let coverPhoto: Photo?
  public let user: User?
  
  enum CodingKeys: String, CodingKey {
    case id, title
    case publishedAt = "published_at"
    case lastCollectedAt = "last_collected_at"
    case updatedAt = "updated_at"
    case coverPhoto = "cover_photo"
    case user
  }
}

extension Photo {
  public init(localId: String, width: Int, height: Int, urls: PhotoURLs) {
    self.id = localId
    self.createdAt = nil
    self.width = width
    self.height = height
    self.color = nil
    self.blurHash = nil
    self.likes = nil
    self.likedByUser = nil
    self.description = nil
    self.user = nil
    self.currentUserCollections = nil
    self.urls = PhotoURLs(regular: urls.regular, thumb: urls.thumb)
    self.links = nil
  }
}
