//
//  GetPhotoFromLocalUseCase.swift
//  Common
//
//  Created by Luthfi Asmara on 15/11/25.
//

import Combine

public protocol GetPhotoOfflineUseCase {
    func execute() -> AnyPublisher<[PhotoObject], Never>
}

public struct GetPhotoOffline: GetPhotoOfflineUseCase {
  let repository: PhotosRepository
    
    public func execute() -> AnyPublisher<[PhotoObject], Never> {
        repository.getPhoto()
            .eraseToAnyPublisher()
    }
}
