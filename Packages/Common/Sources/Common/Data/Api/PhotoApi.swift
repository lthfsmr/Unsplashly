//
//  PhotoApi.swift
//  Common
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Core
import Foundation

enum PhotoApi {
  case searchPhotos(param: SearchPhotosRequest)
}

extension PhotoApi: NetworkModelRequest {
  var path: String {
    switch self {
    case .searchPhotos:
      return "/search/photos"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .searchPhotos:
      return .get
    }
  }
  
  var task: Task {
    switch self {
    case .searchPhotos(let param):
        return .requestParameters(parameters: [
          "query" : param.query ?? "",
          "page" : param.page ?? ""
        ])
    }
  }
  
  var additionalHeaders: HTTPHeaders? {
    nil
  }
}
