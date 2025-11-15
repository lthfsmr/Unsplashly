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
  fileprivate let localDataSource: CommonLocalDataSource
  
  public init(remoteDataSource: CommonRemoteDataSource, localDataSource: CommonLocalDataSource) {
    self.remoteDataSource = remoteDataSource
    self.localDataSource = localDataSource
  }
  
  public func getPhotos(request: SearchPhotosRequest) -> AnyPublisher<[Photo], GeneralError> {
    return remoteDataSource.searchPhotos(request: request)
  }
  
  public func savePhoto(photo: [Photo]) {
    let localPhoto = photo.map { photo -> PhotoObject in
      let object = PhotoObject()
      object.id = photo.id ?? UUID().uuidString
      object.imageUrl = photo.urls?.thumb
      object.width = photo.width
      object.height = photo.height
      return object
    }
    localDataSource.savePhoto(photo: localPhoto)
  }
  
  public func getPhoto() -> AnyPublisher<[PhotoObject], Never> {
    localDataSource.getPhoto()
  }
}
