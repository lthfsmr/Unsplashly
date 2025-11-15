//
//  GetPhotosUseCase.swift
//  Common
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Combine
import Foundation

public protocol GetPhotosUseCase {
  func execute(request: SearchPhotosRequest) -> AnyPublisher<[Photo], GeneralError>
}

open class GetPhotos: GetPhotosUseCase {
  private let repository: PhotosRepository

  public init(repository: PhotosRepository) {
    self.repository = repository
  }

  public func execute(request: SearchPhotosRequest) -> AnyPublisher<[Photo], GeneralError> {
    repository.getPhotos(request: request)
  }
}
