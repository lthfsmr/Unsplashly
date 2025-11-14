//
//  APIConfiguration.swift
//  Core
//
//  Created by Luthfi Asmara on 13/11/25.
//


import Foundation

public struct APIConfiguration {
  public var baseURL: URL
  public var accessKey: String
}

extension APIConfiguration {
  static func developmentConfig() -> APIConfiguration {
    guard let baseURL = URL(string: InfoPlistKey.baseUrl.configValue ?? "") else {
      fatalError("Failed to create one or more base URLs")
    }
    guard let accessKey = InfoPlistKey.accessKey.configValue  else {
      fatalError("Access key empty")
    }
    return APIConfiguration(baseURL: baseURL, accessKey: accessKey)
  }
  
  static func stagingConfig() -> APIConfiguration {
    guard let baseURL = URL(string: InfoPlistKey.baseUrl.configValue ?? "") else {
      fatalError("Failed to create one or more base URLs")
    }
    guard let accessKey = InfoPlistKey.accessKey.configValue  else {
      fatalError("Access key empty")
    }
    return APIConfiguration(baseURL: baseURL, accessKey: accessKey)
  }
  
  static func productionConfig() -> APIConfiguration {
    guard let baseURL = URL(string: InfoPlistKey.baseUrl.configValue ?? "") else {
      fatalError("Failed to create one or more base URLs")
    }
    guard let accessKey = InfoPlistKey.accessKey.configValue  else {
      fatalError("Access key empty")
    }
    return APIConfiguration(baseURL: baseURL, accessKey: accessKey)
  }
}
