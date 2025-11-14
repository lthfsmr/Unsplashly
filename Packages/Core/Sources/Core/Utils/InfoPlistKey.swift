//
//  InfoPlistKey.swift
//  Core
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Foundation

public enum InfoPlistKey: String {
  case baseUrl = "APP_BASE_URL"
  case accessKey = "APP_ACCESS_KEY"
  
  public var configValue: String? {
      let value = Bundle.main.infoDictionary?[self.rawValue] as? String
      return value
  }
}
