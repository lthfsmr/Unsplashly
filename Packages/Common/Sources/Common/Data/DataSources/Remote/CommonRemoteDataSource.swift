//
//  CommonRemoteDataSource.swift
//  Common
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Combine
import Foundation

public protocol CommonRemoteDataSource {
  func searchPhotos(request: SearchPhotosRequest) -> AnyPublisher<BasePhotoResponse, GeneralError>
}

public struct DefaultCommonRemoteDataSource: CommonRemoteDataSource {
  public init() {}
  
  public func searchPhotos(request: SearchPhotosRequest) -> AnyPublisher<BasePhotoResponse, GeneralError> {
    let api = ApiContract.authorized(api: PhotoApi.searchPhotos(param: request))
    return NetworkService.shared
      .fetch(api: api, output: BasePhotoResponse.self)
      .mapError { $0.mapToGeneralError() }
      .eraseToAnyPublisher()
  }
}
