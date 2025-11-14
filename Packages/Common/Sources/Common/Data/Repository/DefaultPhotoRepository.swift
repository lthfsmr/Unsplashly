//
//  DefaultPhotoRepository.swift
//  Common
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Combine
import Foundation

public struct DefaultPhotosRepository: PhotosRepository {
  fileprivate let remoteDataSource: CommonRemoteDataSource
  
  public init(remoteDataSource: CommonRemoteDataSource) {
    self.remoteDataSource = remoteDataSource
  }
  
  public func getPhotos(request: SearchPhotosRequest) -> AnyPublisher<BasePhotoResponse, GeneralError> {
    return remoteDataSource.searchPhotos(request: request)
  }
}
