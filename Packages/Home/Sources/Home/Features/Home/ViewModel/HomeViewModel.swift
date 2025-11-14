//
//  HomeViewModel.swift
//  Home
//
//  Created by Luthfi Asmara on 14/11/25.
//

import UIKit
import Combine
import Core
import Common

class HomeViewModel: ObservableObject {
  @Published var photo: DataState<BasePhotoResponse> = .initiate
  
  private let getPhotosUseCase: GetPhotosUseCase
  
  private var cancellable: Set<AnyCancellable> = []
  
  init(getPhotosUseCase: GetPhotosUseCase) {
    self.getPhotosUseCase = getPhotosUseCase
    
    getPhotos(request: SearchPhotosRequest(page: 1))
  }
  
  var photos: [Photo] = []
  
  func getPhotos(request: SearchPhotosRequest) {
    photo = .loading
    
    getPhotosUseCase.execute(request: request)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        guard let self = self else { return }
        switch completion {
          case .failure(let error):
            print("ERROR: \(error)")
            photo = .failed(reason: error)
          case .finished:
            break
        }
      } receiveValue: { [weak self] data in
        guard let self else { return }
        print("ERROR: \(data)")
        photo = .success(data: data)
      }
      .store(in: &cancellable)
  }
}
