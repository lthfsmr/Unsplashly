//
//  CommonAssembler.swift
//  Common
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Foundation

public protocol CommonAssembler {
  func useCase() -> GetPhotosUseCase
  func useCase() -> GetPhotoOfflineUseCase
  func useCase() -> SaveToLocalUseCase
  func repository() -> PhotosRepository
  func remoteDataSource() -> CommonRemoteDataSource
  func localDataSource() -> CommonLocalDataSource
}

public extension CommonAssembler {
  func useCase() -> GetPhotosUseCase {
    return GetPhotos(repository: repository())
  }
  
  func useCase() -> GetPhotoOfflineUseCase {
    return GetPhotoOffline(repository: repository())
  }
  
  func useCase() -> SaveToLocalUseCase {
    return SaveToLocal(repository: repository())
  }
  
  func repository() -> PhotosRepository {
    return DefaultPhotosRepository(remoteDataSource: remoteDataSource(), localDataSource: localDataSource())
  }
  
  func remoteDataSource() -> CommonRemoteDataSource {
    return DefaultCommonRemoteDataSource()
  }
  
  func localDataSource() -> CommonLocalDataSource {
    return DefaultCommonLocalDataSource()
  }
}
