//
//  CommonAssembler.swift
//  Common
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Foundation

public protocol CommonAssembler {
  func useCase() -> GetPhotosUseCase
  func repository() -> PhotosRepository
  func remoteDataSource() -> CommonRemoteDataSource
}

public extension CommonAssembler {
  func useCase() -> GetPhotosUseCase {
    return GetPhotos(repository: repository())
  }
  
  func repository() -> PhotosRepository {
    return DefaultPhotosRepository(remoteDataSource: remoteDataSource())
  }
  
  func remoteDataSource() -> CommonRemoteDataSource {
    return DefaultCommonRemoteDataSource()
  }
}
