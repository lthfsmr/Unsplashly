//
//  PhotoRepository.swift
//  Common
//
//  Created by Luthfi Asmara on 14/11/25.
//

import Combine
import Foundation

public protocol PhotosRepository {
  func getPhotos(request: SearchPhotosRequest) -> AnyPublisher<BasePhotoResponse, GeneralError>
}
