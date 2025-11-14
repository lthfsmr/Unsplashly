//
//  ApiContract.swift
//  Common
//
//  Created by Luthfi Asmara on 13/11/25.
//

import Core
import Foundation
import UIKit

import Foundation

public enum ApiContract {
  case anonymous(api: NetworkModelRequest)
  case authorized(api: NetworkModelRequest)
}

extension ApiContract {
  public var baseURL: URL {
    AppConfig.current.apiConfig.baseURL
  }

  var api: NetworkModelRequest {
    switch self {
      case .anonymous(let api),
          .authorized(let api):
        return api
    }
  }

  public var path: String {
    api.path
  }

  public var method: HTTPMethod {
    api.method
  }

  var task: Task {
    api.task
  }

  public var headers: [String: String]? {
    switch self {
      case .anonymous:
        return getHeaders(type: .anonymous)
      case .authorized:
        return getHeaders(type: .authorized)
    }
  }
}

private enum HeaderType {
  case anonymous
  case authorized
}

extension ApiContract {
  private func getHeaders(type: HeaderType) -> [String: String] {
    var header = ["Accept": "application/json"]
    switch type {
      case .authorized:
        let accessKey = AppConfig.current.apiConfig.accessKey
        header["Authorization"] = "Client-ID \(accessKey)"
      case .anonymous:
        break
    }
    
    return header
  }
}
