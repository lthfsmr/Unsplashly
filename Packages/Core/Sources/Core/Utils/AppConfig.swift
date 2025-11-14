//
//  AppConfig.swift
//  Core
//
//  Created by Luthfi Asmara on 13/11/25.
//

import Foundation

/// Represents the app environment.
public enum AppEnvironment {
  case development
  case staging
  case production
}

/// Main app configuration based on the current environment.
public struct AppConfig {
  public static var current = AppConfig(environment: .development)
  
  public var environment: AppEnvironment
  
  public init(environment: AppEnvironment) {
    self.environment = environment
  }
  
  public var apiConfig: APIConfiguration {
    switch environment {
    case .development:
      return APIConfiguration.developmentConfig()
    case .staging:
      return APIConfiguration.stagingConfig()
    case .production:
      return APIConfiguration.productionConfig()
    }
  }
}
