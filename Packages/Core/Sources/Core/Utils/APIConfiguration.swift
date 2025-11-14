//
//  APIConfiguration.swift
//  Core
//
//  Created by Luthfi Asmara on 13/11/25.
//


import Foundation

public struct APIConfiguration {
  public var baseURL: URL
  public var accessKey: String = "d8a272c480b258b875d82f4062d6c52e4ae7f4b4656add778d71e9b638b2f8be"
}

extension APIConfiguration {
  static func developmentConfig() -> APIConfiguration {
    let baseURL = URL(string: "https://unsplash.com/")
    guard let baseURL = baseURL else {
      fatalError("Failed to create one or more base URLs")
    }
    return APIConfiguration(baseURL: baseURL)
  }
  
  static func stagingConfig() -> APIConfiguration {
    let baseURL = URL(string: "https://unsplash.com/")
    guard let baseURL = baseURL else {
      fatalError("Failed to create one or more base URLs")
    }
    
    return APIConfiguration(baseURL: baseURL)
  }
  
  static func productionConfig() -> APIConfiguration {
    let baseURL = URL(string: "https://unsplash.com/")
    
    guard let baseURL = baseURL else {
      fatalError("Failed to create one or more base URLs")
    }
    
    return APIConfiguration(baseURL: baseURL)
  }
}
