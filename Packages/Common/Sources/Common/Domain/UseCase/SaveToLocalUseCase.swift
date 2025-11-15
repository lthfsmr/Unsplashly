//
//  SaveToLocalUseCase.swift
//  Common
//
//  Created by Luthfi Asmara on 15/11/25.
//


import Foundation

public protocol SaveToLocalUseCase {
    func execute(photo: [Photo])
}

public struct SaveToLocal: SaveToLocalUseCase {
  let repository: PhotosRepository
    
    public func execute(photo: [Photo]) {
        repository.savePhoto(photo: photo)
    }
}
